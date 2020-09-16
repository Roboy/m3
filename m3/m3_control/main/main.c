#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/event_groups.h"
#include "freertos/queue.h"
#include "esp_system.h"
#include "esp_wifi.h"
#include "esp_event.h"
#include "esp_log.h"
#include "nvs_flash.h"
#include "sys/socket.h"
#include "sys/time.h"
#include "lwip/err.h"
#include "lwip/sys.h"
#include <stdio.h>
#include <driver/ledc.h>
#include "driver/uart.h"
#include "driver/gpio.h"
#include "esp_timer.h"
#include "sdkconfig.h"
#include "esp_log.h"
#include "esp_event_loop.h"

// #define WIFI_CONTROL
static const char *TAG = "m3 control";

#define ID 128

static int64_t t0 = 0, t1 = 0;
#define MIRRORED
#define DEFAULT_SETPOINT 10

static bool E0, E1;

static xQueueHandle gpio_evt_queue = NULL;

static float Kp = 20;
static float Ki = 0;
static float Kd = 0;
static float deadband = 0;
static float IntegralLimit = 0;
static float PWMLimit = 1600;
static uint8_t control_mode = 0;
static float setpoint = 0;
static int32_t pos = 0;
static int32_t vel = 0;
static int32_t dis = 0;
static int32_t pwm = 0;

#ifdef WIFI_CONTROL

struct{
    int32_t motor;
    int32_t pos;
    int32_t vel;
    int32_t dis;
    int32_t pwm;
}status_frame;

struct{
    int32_t motor;
    int32_t setpoint;
}command_frame;

struct{
    int32_t motor;
    int32_t mode;
    int32_t Kp;
    int32_t Ki;
    int32_t Kd;
}control_frame;

#define HOST_IP_ADDR "192.168.255.255"
#define PORT 8000

/* The examples use WiFi configuration that you can set via 'make menuconfig'.

   If you'd rather not, just change the below entries to strings with
   the config you want - ie #define EXAMPLE_WIFI_SSID "mywifissid"
*/
#define EXAMPLE_ESP_WIFI_SSID      "roboy"
#define EXAMPLE_ESP_WIFI_PASS      "wiihackroboy"
#define EXAMPLE_ESP_MAXIMUM_RETRY  10

/* FreeRTOS event group to signal when we are connected*/
static EventGroupHandle_t s_wifi_event_group;

/* The event group allows multiple bits for each event, but we only care about one event
 * - are we connected to the AP with an IP? */
const int WIFI_CONNECTED_BIT = BIT0;

/* FreeRTOS event group to signal when we are connected*/
static EventGroupHandle_t wifi_event_group;

static int s_retry_num = 0;

static void command_task(void *pvParameters)
{
    char rx_buffer[128];
    int addr_family;
    int ip_protocol;

    command_frame.setpoint = DEFAULT_SETPOINT;

    while (1) {

        struct sockaddr_in local_addr;
        addr_family = AF_INET;
        ip_protocol = IPPROTO_IP;

        int sock = socket(addr_family, SOCK_DGRAM, ip_protocol);
        if (sock < 0) {
            ESP_LOGE(TAG, "Unable to create socket: errno %d", errno);
            break;
        }

        local_addr.sin_family = AF_INET;
        local_addr.sin_addr.s_addr = htonl(INADDR_ANY);
        local_addr.sin_port = htons(8001);
        if (bind(sock, (struct sockaddr *) &local_addr, sizeof local_addr) < 0) {
            ESP_LOGE(TAG, "bind port error");
            break;
        }
        //set timer for recv_socket
        static int timeout = 10;
        setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO,(char*)&timeout,sizeof(timeout));
        while (1) {
            struct sockaddr_in source_addr; // Large enough for both IPv4 or IPv6
            socklen_t socklen = sizeof(source_addr);
            int len = recvfrom(sock, rx_buffer, sizeof(rx_buffer) - 1, 0, (struct sockaddr *)&source_addr, &socklen);
            // Error occurred during receiving
            if (len == 10) {
                int m;
                memcpy(&m,&rx_buffer[4],4);
                if(m==command_frame.motor){
                    memcpy(&command_frame.setpoint,rx_buffer,4);
                }
                //ESP_LOGI(TAG,"Received command_frame for motor %d with setpoint %d", m, command_frame.setpoint);
            }else if(len == 20){
                int m,kp,ki,kd,mode;
                memcpy(&m,&rx_buffer[16],4);
                if(m==command_frame.motor) {
                    memcpy(&mode, &rx_buffer[12], 4);
                    memcpy(&kp, &rx_buffer[8], 4);
                    memcpy(&ki, &rx_buffer[4], 4);
                    memcpy(&kd, &rx_buffer[0], 4);
                    if(mode==0){
                        command_frame.setpoint = status_frame.pos;
                    }else if(mode == 1){
                        command_frame.setpoint = 0;
                    }else if(mode ==2){
                        command_frame.setpoint = 0;
                    }
                    control_frame.mode = mode;
                    control_frame.Kp = kp;
                    control_frame.Ki = ki;
                    control_frame.Kd = kd;
                    //ESP_LOGI(TAG, "Received control_frame for motor %d mode %d kp %d ki %d kd %d", m, mode, kp, ki, kd);
//                if(m==command_frame.motor){
//                    memcpy(&command_frame.setpoint,rx_buffer,4);
//                }
                }
            }
        }

        if (sock != -1) {
            ESP_LOGE(TAG, "Shutting down socket and restarting...");
            shutdown(sock, 0);
            close(sock);
        }
    }
    vTaskDelete(NULL);
}

static void status_task(void *pvParameters)
{
    char addr_str[128];
    int addr_family;
    int ip_protocol;
    status_frame.vel = 0;

    int64_t t0_vel = 0, t1_vel = 0;
    t0_vel = esp_timer_get_time();
    int pos_prev = 0;

    printf("my id is %d\n", id);
    status_frame.motor = id;
    status_frame.dis = 0;
    command_frame.motor = id;

    while (1) {

        struct sockaddr_in dest_addr;
        dest_addr.sin_addr.s_addr = inet_addr(HOST_IP_ADDR);
        dest_addr.sin_family = AF_INET;
        dest_addr.sin_port = htons(PORT);
        addr_family = AF_INET;
        ip_protocol = IPPROTO_IP;
        inet_ntoa_r(dest_addr.sin_addr, addr_str, sizeof(addr_str) - 1);

        int sock = socket(addr_family, SOCK_DGRAM, ip_protocol);
        if (sock < 0) {
            ESP_LOGE(TAG, "Unable to create socket: errno %d", errno);
            break;
        }

        while (1) {
            t1_vel = esp_timer_get_time();
            int err = sendto(sock, (char*)&status_frame, sizeof(status_frame), 0, (struct sockaddr *)&dest_addr, sizeof(dest_addr));
            if (err < 0) {
//                ESP_LOGE(TAG, "Error occurred during sending: errno %d", errno);
                break;
            }
            ESP_LOGD(TAG, "Message sent");
            float dt = (t1_vel-t0_vel)/1000.0f; // ticks per/ms
            float vel = (dt>0?(status_frame.pos-pos_prev)/dt:0);
            status_frame.vel = vel;

//            ESP_LOGI("vel", "%f %f",vel, dt);
            pos_prev = status_frame.pos;
            t0_vel = t1_vel;
            vTaskDelay(200 / portTICK_PERIOD_MS);
            // ESP_LOGI("displacement", "%d %d -> %d",E0,E1,status_frame.dis);
        }

        if (sock != -1) {
//            ESP_LOGE(TAG, "Shutting down socket and restarting...");
            shutdown(sock, 0);
            close(sock);
        }
    }
    vTaskDelete(NULL);
}

static esp_err_t event_handler(void *ctx, system_event_t *event)
{
    /* For accessing reason codes in case of disconnection */
    system_event_info_t *info = &event->event_info;

    switch(event->event_id) {
        case SYSTEM_EVENT_STA_START:
            esp_wifi_connect();
            break;
        case SYSTEM_EVENT_STA_GOT_IP:
            ESP_LOGI(TAG, "got ip:%s",
                     ip4addr_ntoa(&event->event_info.got_ip.ip_info.ip));
            xEventGroupSetBits(wifi_event_group, WIFI_CONNECTED_BIT);
            break;
        case SYSTEM_EVENT_AP_STACONNECTED:
            ESP_LOGI(TAG, "station:"MACSTR" join, AID=%d",
                     MAC2STR(event->event_info.sta_connected.mac),
                     event->event_info.sta_connected.aid);
            break;
        case SYSTEM_EVENT_AP_STADISCONNECTED:
            ESP_LOGI(TAG, "station:"MACSTR"leave, AID=%d",
                     MAC2STR(event->event_info.sta_disconnected.mac),
                     event->event_info.sta_disconnected.aid);
            break;
        case SYSTEM_EVENT_STA_DISCONNECTED:
            ESP_LOGE(TAG, "Disconnect reason : %d", info->disconnected.reason);
            if (info->disconnected.reason == WIFI_REASON_BASIC_RATE_NOT_SUPPORT) {
                /*Switch to 802.11 bgn mode */
                esp_wifi_set_protocol(ESP_IF_WIFI_STA, WIFI_PROTOCAL_11B | WIFI_PROTOCAL_11G | WIFI_PROTOCAL_11N);
            }
            esp_wifi_connect();
            xEventGroupClearBits(wifi_event_group, WIFI_CONNECTED_BIT);
            break;
        default:
            break;
    }
    return ESP_OK;
}

void wifi_init_sta()
{
    wifi_event_group = xEventGroupCreate();

    tcpip_adapter_init();
    ESP_ERROR_CHECK(esp_event_loop_init(event_handler, NULL) );

    wifi_init_config_t cfg = WIFI_INIT_CONFIG_DEFAULT();
    ESP_ERROR_CHECK(esp_wifi_init(&cfg));
    wifi_config_t wifi_config = {
            .sta = {
                    .ssid = EXAMPLE_ESP_WIFI_SSID,
                    .password = EXAMPLE_ESP_WIFI_PASS
            },
    };

    ESP_ERROR_CHECK(esp_wifi_set_mode(WIFI_MODE_STA) );
    ESP_ERROR_CHECK(esp_wifi_set_config(ESP_IF_WIFI_STA, &wifi_config) );
    ESP_ERROR_CHECK(esp_wifi_start() );

    ESP_LOGI(TAG, "wifi_init_sta finished.");
    ESP_LOGI(TAG, "connect to ap SSID:%s password:%s",
             EXAMPLE_ESP_WIFI_SSID, EXAMPLE_ESP_WIFI_PASS);
}

#else

  #define EX_UART_NUM UART_NUM_0
  #define BUF_SIZE (1024)
  #define RD_BUF_SIZE (BUF_SIZE)
  static QueueHandle_t uart0_queue;

  #pragma pack(1)
  /*
   * The width of the CRC calculation and result.
   * Modify the typedef for a 16 or 32-bit CRC standard.
   */
  typedef uint16_t crc;

  #define WIDTH  (8 * sizeof(crc))
  #define TOPBIT (1 << (WIDTH - 1))
  #define POLYNOMIAL 0x8005

  #define HEADER_LENGTH 4
  #define MAX_FRAME_LENGTH 36

  union StatusRequest{
    struct __attribute__((packed)) {
          uint32_t header;
          uint8_t id;
          uint16_t crc;
      }values;
      uint8_t data[7];
  };

  union M3Command{
    struct __attribute__((packed)) {
          uint32_t header;
          uint8_t id;
          int32_t setpoint;
          uint16_t crc;
      }values;
      uint8_t data[11];
  };

  union M3ControlMode{
    struct __attribute__((packed)) {
          uint32_t header;
          uint8_t id;
          uint8_t control_mode;
          uint32_t setpoint;
          uint32_t Kp;
          uint32_t Ki;
          uint32_t Kd;
          uint32_t deadband;
          uint32_t IntegralLimit;
          uint32_t PWMLimit;
          uint16_t crc;
      }values;
      uint8_t data[36];
  };

  union M3StatusResponse{
    struct __attribute__((packed)) {
          uint32_t header;
          uint8_t id;
          uint8_t control_mode;
          int32_t setpoint;
          int32_t pos;
          int32_t vel;
          int32_t dis;
          int32_t pwm;
          uint16_t crc;
      }values;
      uint8_t data[28];
  };

  struct Frame{
    union{
      uint8_t bytes[4];
      int32_t val;
    }header;
    uint length;
    uint8_t data[MAX_FRAME_LENGTH];
    uint frame_index;
    bool active, dirty;
    int type;
    int counter;
  };

  struct Frame frames[3];
  crc  crcTable[256];
  static void crcInit(){
    crc  remainder;
    for (int dividend = 0; dividend < 256; ++dividend){
        remainder = dividend << (WIDTH - 8);
        for (uint8_t bit = 8; bit > 0; --bit){
            if (remainder & TOPBIT){
                remainder = (remainder << 1) ^ POLYNOMIAL;
            }else{
                remainder = (remainder << 1);
            }
        }
        crcTable[dividend] = remainder;
    }
  }
  static crc gen_crc16(const uint8_t *message, uint16_t nBytes){
    uint8_t data;
    crc remainder = 0xffff;
    for (int byte = 0; byte < nBytes; ++byte)
    {
        data = message[byte] ^ (remainder >> (WIDTH - 8));
        remainder = crcTable[data] ^ (remainder << 8);
    }
    return (remainder<<8|remainder>>8);
  }

  static void frameMatch(){
    for(int i=0;i<3;i++){
      if(frames[i].dirty){
        if(frames[i].data[4]==ID){
          crc crc_received = gen_crc16(&frames[i].data[HEADER_LENGTH],frames[i].length-HEADER_LENGTH-2);
          if(crc_received==(frames[i].data[frames[i].length-1]<<8|frames[i].data[frames[i].length-2])){
            switch(frames[i].type){
              case 0: { // status_request
                  #ifdef PRINTOUTS
                  ESP_LOGI(TAG, );
                  ESP_LOGI(TAG, "status_request %d received for id %d",frames[i].counter,frames[i].data[4]);
                  #endif
                  union M3StatusResponse msg;
                  msg.values.header = 0x00D0BADA;
                  msg.values.id = ID;
                  msg.values.control_mode = control_mode;
                  msg.values.setpoint = setpoint;
                  msg.values.pos = pos;
                  msg.values.vel = vel;
                  msg.values.dis = dis;
                  msg.values.pwm = pwm;
                  msg.values.crc = gen_crc16(&msg.data[4],sizeof(msg)-HEADER_LENGTH-2);
                  uart_write_bytes(EX_UART_NUM, (const char *) msg.data, sizeof(msg));
                break;
              }
              case 1: { // hand_command
                union M3Command msg;
                memcpy(msg.data,frames[i].data,frames[i].length);
                setpoint = msg.values.setpoint;
                #ifdef PRINTOUTS
                ESP_LOGI(TAG, "\thand_command %d received for id %d\tsetpoint %d",
                  frames[i].counter,frames[i].data[4],msg.values.setpoint);
                #endif

                break;
              }
              case 2: { // hand_control_mode
                union M3ControlMode msg;
                memcpy(msg.data,frames[i].data,frames[i].length);
                control_mode = msg.values.control_mode;
                setpoint = msg.values.setpoint;
                Kp = msg.values.Kp/20.0f;
                Ki = msg.values.Ki/20.0f;
                Kd = msg.values.Kd/20.0f;
                deadband = msg.values.deadband;
                IntegralLimit = msg.values.IntegralLimit;
                PWMLimit = msg.values.PWMLimit;
                #ifdef PRINTOUTS
                ESP_LOGI(TAG, "\thand_control_mode %d received for id %d \tcontrol_mode %d",
                frames[i].counter,frames[i].data[4],msg.values.control_mode);
                #endif
                break;
              }
            }
          }else{
            #ifdef PRINTOUTS
            ESP_LOGI(TAG, "crc error, calculated %x \t received %x",crc_received,(frames[i].data[frames[i].length-1]<<8|frames[i].data[frames[i].length-2]));
            #endif
          }
        }else{
            gpio_set_level(GPIO_NUM_16,0);
        }
//        #ifdef PRINTOUTS
//        else{
//          ESP_LOGI(TAG, "not for me, it's for ");
//          SERIAL.println(frames[i].data[4]);
//        }
//        #endif
        frames[i].dirty = false;
      }
    }
  }

  static void receive(uint8_t val){
    for(int i=0;i<3;i++){
      if(!frames[i].active){
        if(val==frames[i].header.bytes[frames[i].frame_index]){
//           ESP_LOGI(TAG, val,HEX);
//           ESP_LOGI(TAG, " matches byte number ");
//           SERIAL.println(frames[i].frame_index);
          frames[i].frame_index++;
          if(frames[i].frame_index==4){
            frames[i].active = true;
//             ESP_LOGI(TAG, frames[i].type);
//             SERIAL.println(" frame matched");
          }
        }else{
          frames[i].frame_index = 0;
        }
      }else{
        if(frames[i].frame_index<frames[i].length-1){
          frames[i].data[frames[i].frame_index] = val;
          frames[i].frame_index++;
        }else{
          frames[i].data[frames[i].frame_index] = val;
          frames[i].counter++;
          frames[i].active = false;
          frames[i].dirty = true;
          frames[i].frame_index = 0;
          gpio_set_level(GPIO_NUM_16,1);
          frameMatch();
        }
      }
    }
  }

  static void command_task(void *pvParameters)
  {
      uart_event_t event;
      uint8_t *dtmp = (uint8_t *) malloc(RD_BUF_SIZE);

      frames[0].type = 0;
      frames[0].header.val = 0xBBCEE11C;
      frames[0].length = 7;

      frames[1].type = 1;
      frames[1].header.val = 0xBEBAFECA;
      frames[1].length = 11;

      frames[2].type = 2;
      frames[2].header.val = 0x0DD0FECA;
      frames[2].length = 36;

      crcInit();

      for (;;) {
          // Waiting for UART event.
          if (xQueueReceive(uart0_queue, (void *)&event, (portTickType)portMAX_DELAY)) {
              bzero(dtmp, RD_BUF_SIZE);
              // ESP_LOGI(TAG, "uart[%d] event:", EX_UART_NUM);

              switch (event.type) {
                  // Event of UART receving data
                  // We'd better handler data event fast, there would be much more data events than
                  // other types of events. If we take too much time on data event, the queue might be full.
                  case UART_DATA:
                      uart_read_bytes(EX_UART_NUM, dtmp, event.size, portMAX_DELAY);
                      for(int i=0;i<event.size;i++){
                        receive(dtmp[i]);
                      }
                      break;

                  // Event of HW FIFO overflow detected
                  case UART_FIFO_OVF:
                      ESP_LOGI(TAG, "hw fifo overflow");
                      // If fifo overflow happened, you should consider adding flow control for your application.
                      // The ISR has already reset the rx FIFO,
                      // As an example, we directly flush the rx buffer here in order to read more data.
                      uart_flush_input(EX_UART_NUM);
                      xQueueReset(uart0_queue);
                      break;

                  // Event of UART ring buffer full
                  case UART_BUFFER_FULL:
                      ESP_LOGI(TAG, "ring buffer full");
                      // If buffer full happened, you should consider encreasing your buffer size
                      // As an example, we directly flush the rx buffer here in order to read more data.
                      uart_flush_input(EX_UART_NUM);
                      xQueueReset(uart0_queue);
                      break;

                  case UART_PARITY_ERR:
                      ESP_LOGI(TAG, "uart parity error");
                      break;

                  // Event of UART frame error
                  case UART_FRAME_ERR:
                      ESP_LOGI(TAG, "uart frame error");
                      break;

                  // Others
                  default:
                      ESP_LOGI(TAG, "uart event type: %d", event.type);
                      break;
              }
          }
      }

      free(dtmp);
      dtmp = NULL;
      vTaskDelete(NULL);
  }

#endif


static void IRAM_ATTR gpio_isr_handler(void* arg)
{
    uint32_t gpio_num = (uint32_t) arg;
    xQueueSendFromISR(gpio_evt_queue, &gpio_num, NULL);
    if(gpio_get_level(gpio_num)==0)
        t0 = esp_timer_get_time();
    else
        t1 = esp_timer_get_time();
}

void displacement_task(void *ignore) {
  while(1) {
      printf("displacement %d\n", dis);
      vTaskDelay(pdMS_TO_TICKS(100));
  } // End loop forever

  vTaskDelete(NULL);
}

static void IRAM_ATTR gpio_isr_handler_E0(void* arg)
{
    uint32_t gpio_num = (uint32_t) arg;
    xQueueSendFromISR(gpio_evt_queue, &gpio_num, NULL);
    if(gpio_get_level(gpio_num)==0){
        E0 = false;
        if(E1){
          dis++;
        }else{
          dis--;
        }
    }else{
        E0 = true;
        if(!E1){
          dis++;
        }else{
          dis--;
        }
    }
}

static void IRAM_ATTR gpio_isr_handler_E1(void* arg)
{
    uint32_t gpio_num = (uint32_t) arg;
    xQueueSendFromISR(gpio_evt_queue, &gpio_num, NULL);
    if(gpio_get_level(gpio_num)==0){
        E1 = false;
        if(!E0){
          dis++;
        }else{
          dis--;
        }
    }else{
        E1 = true;
        if(E0){
          dis++;
        }else{
          dis--;
        }
    }
}

void servo_task(void *ignore) {
    int zeroSpeed       = 610;
    ledc_timer_config_t ledc_timer = {
            .duty_resolution = LEDC_TIMER_15_BIT, // resolution of PWM duty
            .freq_hz = 50,                      // frequency of PWM signal
            .speed_mode = LEDC_HIGH_SPEED_MODE,           // timer mode
            .timer_num = LEDC_TIMER_0            // timer index
    };
    ledc_timer_config(&ledc_timer);

    ledc_channel_config_t ledc_conf = {
            .channel    = LEDC_CHANNEL_0,
            .duty       = 0,
            .gpio_num   = 5,
            .speed_mode = LEDC_HIGH_SPEED_MODE,
            .hpoint     = 0,
            .timer_sel  = LEDC_TIMER_0
    };
    ledc_channel_config(&ledc_conf);

    ledc_fade_func_install(0);

    esp_log_level_set("ledc", ESP_LOG_NONE);

    vTaskDelay(pdMS_TO_TICKS(1000));
    ledc_set_duty(LEDC_HIGH_SPEED_MODE, LEDC_CHANNEL_0, zeroSpeed);

    setpoint = 0.03*1600;

    control_mode = 3;

    vel = 0;
    float error_prev = 0, integral = 0;
    while(1) {
        float error, output;             // Control system variables
        switch(control_mode){
            case 0:
                error = pos-setpoint;         // Calculate error
                break;
            case 1:
                error = vel-setpoint;         // Calculate error
                break;
            case 2:
                if(setpoint>=0) {
#ifndef MIRRORED
                    error = dis - setpoint;         // Calculate error
#else
                    error = -(dis - setpoint);         // Calculate error
#endif
                }else
                    error = 0;
                break;
            case 3:
              error = 0;
              output = setpoint/2;
              break;
            default:
                error = 0;
        }
        integral += error;
        if(integral>IntegralLimit)
          integral = IntegralLimit;
        if(integral<-IntegralLimit)
          integral = -IntegralLimit;
        if(control_mode!=3)
          output = error * Kp + (error-error_prev)*Kd + Ki * integral;                 // Calculate PID result

        if(output > (PWMLimit/1600.0f*50))
            output = PWMLimit/1600.0f*50;            // Clamp output
        if(output < -(PWMLimit/1600.0f*50))
            output = -PWMLimit/1600.0f*50;
        ledc_set_duty(LEDC_HIGH_SPEED_MODE, LEDC_CHANNEL_0, zeroSpeed+output);
        ledc_update_duty(LEDC_HIGH_SPEED_MODE, LEDC_CHANNEL_0);
        pwm = output;
        vTaskDelay(pdMS_TO_TICKS(50));
        error_prev = error;
    } // End loop forever

    vTaskDelete(NULL);
}

void feedback360_task()                            // Cog keeps angle variable updated
{
    int unitsFC = 360;                          // Units in a full circle
    int dutyScale = 1000;                       // Scale duty cycle to 1/1000ths
    int dcMin = 29;                             // Minimum duty cycle
    int dcMax = 971;                            // Maximum duty cycle
    int q2min = unitsFC/4;                      // For checking if in 1st quadrant
    int q3max = q2min * 3;                      // For checking if in 4th quadrant
    int turns = 0;                              // For tracking turns
    // dc is duty cycle, theta is 0 to 359 angle, thetaP is theta from previous
    // loop repetition, tHigh and tLow are the high and low signal times for
    // duty cycle calculations.
    int dc, theta, thetaP, tHigh = 1200, tLow = 0;

    // Calcualte initial duty cycle and angle.
    dc = (dutyScale * tHigh) / (tHigh + tLow);
    theta = (unitsFC - 1) - ((dc - dcMin) * unitsFC) / (dcMax - dcMin + 1);
    thetaP = theta;

    int io_num = 4;

    int pos_tmp = 0, pos_offset = 0;
    bool first = true;

    while(1)                                    // Main loop for this cog
    {
        int tHigh = 0, tLow = 0, tCycle = 0;
        while(1)                                  // Keep checking
        {
            if(xQueueReceive(gpio_evt_queue, &io_num, portMAX_DELAY)) {
                if(gpio_get_level(io_num)==0){
                    tLow = abs(t1-t0);
                }else{
                    tHigh = abs(t0-t1);
                }
                if(tHigh!=0 && tLow!=0){
                    tCycle = tHigh + tLow;
                    if((tCycle > 1000) && (tCycle < 1200)) {  // If cycle time valid
                        break;                                // break from loop
                    }
                }
            }                            // break from loop
        }
        dc = (dutyScale * tHigh) / tCycle;        // Calculate duty cycle

        // This gives a theta increasing int the
        // counterclockwise direction.
        theta = (unitsFC - 1) -                   // Calculate angle
                ((dc - dcMin) * unitsFC)
                / (dcMax - dcMin + 1);

        if(theta < 0)                             // Keep theta valid
            theta = 0;
        else if(theta > (unitsFC - 1))
            theta = unitsFC - 1;

        // If transition from quadrant 4 to
        // quadrant 1, increase turns count.
        if((theta < q2min) && (thetaP > q3max))
            turns++;
            // If transition from quadrant 1 to
            // quadrant 4, decrease turns count.
        else if((thetaP < q2min) && (theta > q3max))
            turns --;

        // Construct the angle measurement from the turns count and
        // current theta value.
        if(turns >= 0)
            pos_tmp = (turns * unitsFC) + theta;
        else if(turns <  0)
            pos_tmp = ((turns + 1) * unitsFC) - (unitsFC - theta);

        if(first){
            first = false;
            pos_offset = pos_tmp;
            pos = 0;
        }else{
            pos = pos_tmp-pos_offset;
        }

//        ESP_LOGD("timer", "angle = %d", status_frame.pos);

        thetaP = theta;                           // Theta previous for next rep
    }
}

void app_main()
{
    gpio_config_t io_conf;
    //disable interrupt
    io_conf.intr_type = GPIO_INTR_ANYEDGE;
    //set as output mode
    io_conf.mode = GPIO_MODE_INPUT;
    //bit mask of the pins that you want to set,e.g.GPIO18/19
    io_conf.pin_bit_mask = (1ULL<<4|1ULL<<13|1ULL<<14);
    //disable pull-down mode
    io_conf.pull_down_en = 0;
    //disable pull-up mode
    io_conf.pull_up_en = 0;
    gpio_config(&io_conf);

    //create a queue to handle gpio event from isr
    gpio_evt_queue = xQueueCreate(10, sizeof(uint32_t));

    //install gpio isr service
    gpio_install_isr_service(0);
    //hook isr handler for specific gpio pin
    gpio_isr_handler_add(4, gpio_isr_handler, (void*) 4);

    gpio_isr_handler_add(13, gpio_isr_handler_E0, (void*) 13);
    gpio_isr_handler_add(14, gpio_isr_handler_E1, (void*) 14);
    #ifdef WIFI_CONTROL
      wifi_init_sta();
      xTaskCreate(&status_task,"status_task",2048,NULL,5,NULL);
      printf("status_task started\n");
    #else
      //disable interrupt
      io_conf.intr_type = GPIO_INTR_DISABLE;
      //set as output mode
      io_conf.mode = GPIO_MODE_OUTPUT;
      //bit mask of the pins that you want to set,e.g.GPIO18/19
      io_conf.pin_bit_mask = (1ULL<<16);
      //disable pull-down mode
      io_conf.pull_down_en = 0;
      //disable pull-up mode
      io_conf.pull_up_en = 0;
      gpio_config(&io_conf);
      gpio_set_level(GPIO_NUM_16,0);
      // Configure parameters of an UART driver,
      // communication pins and install the driver
      uart_config_t uart_config = {
          .baud_rate = 460800,
          .data_bits = UART_DATA_8_BITS,
          .parity = UART_PARITY_DISABLE,
          .stop_bits = UART_STOP_BITS_1,
          .flow_ctrl = UART_HW_FLOWCTRL_DISABLE
      };
      uart_param_config(EX_UART_NUM, &uart_config);

      // Install UART driver, and get the queue.
      uart_driver_install(EX_UART_NUM, BUF_SIZE * 2, BUF_SIZE * 2, 100, &uart0_queue, 0);
    #endif

    // xTaskCreate(&displacement_task,"displacement_task",2048,NULL,1,NULL);
    // printf("displacement_task started\n");
    xTaskCreate(&command_task,"command_task",2048,NULL,3,NULL);
    printf("command_task started\n");
    xTaskCreate(&feedback360_task,"feedback360_task",2048,NULL,4,NULL);
    printf("feedback360_task started\n");
    xTaskCreate(&servo_task,"servo_task",2048,NULL,1,NULL);
    printf("servo_task started\n");
}
