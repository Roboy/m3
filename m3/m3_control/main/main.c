#include <stdio.h>
#include <string.h>

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/event_groups.h"
#include "freertos/queue.h"

#include "esp_system.h"
#include "esp_wifi.h"
#include "esp_event.h"
#include "esp_log.h"
#include "esp_timer.h"
#include "esp_event_loop.h"

#include "nvs_flash.h"
#include "sys/socket.h"
//#include "sys/time.h"

#include "lwip/err.h"
#include "lwip/sys.h"

#include "driver/gpio.h"
#include "driver/pwm.h"
#include "driver/uart.h"

#include "sdkconfig.h"

// #define WIFI_CONTROL
static const char *TAG = "m3 control";

#define ID 128

#define MIRRORED 0
#define DEFAULT_SETPOINT 10

// PWM CONFIG
#define N_PWM_PINS 1
#define PWM_PERIOD 20000                // 50Hz -> 20k us
#define PWM_MAX_DUTY PWM_PERIOD
#define PWM_MAX_RANGE PWM_MAX_DUTY/100  // 200us/PWM_UNIT_TIME_RESOLUTION =
                                        // = 200us/(20ms/PWM_MAX_DUTY)
#define ZERO_SPEED 15*(PWM_MAX_DUTY/200)// 1500 us
#define PWM_OFFSET PWM_MAX_DUTY/1000    // 20 us

static const uint32_t pwm_pin = GPIO_NUM_5;
static int16_t phase = 0;
static uint32_t duty = ZERO_SPEED;


static bool E0, E1;

static xQueueHandle gpio_evt_queue = NULL;

static float Kp = 1;
static float Ki = 1;
static float Kd = 1;
static float deadband = 0;
static uint32_t IntegralLimit = 0;
static uint32_t PWM_LIMIT = PWM_MAX_RANGE;
static uint8_t control_mode = 0;
static float setpoint = 0;
static int32_t pos = 0;
static int32_t vel = 0;
static volatile int32_t dis = 0;
static int32_t pwm = 0;

/* Angle feedback task handle */
static TaskHandle_t task_fb360_handle = NULL;

#define FB360_PIN 4   // Pin for servo angle readout
static volatile uint32_t fbtime_meas[3];
static volatile bool fbtime_valid = 0;

#define portYIELD_FROM_ISR() portYIELD()

////////// SECTION ONLY RELEVANT FOR WIRELESS CONTROL ////////// 
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
////////// END OF WI-FI ONLY SECTION //////////

  #define EX_UART_NUM UART_NUM_0
  #define BUF_SIZE (1024)
  #define RD_BUF_SIZE (BUF_SIZE)
  static QueueHandle_t uart0_queue;

  #pragma pack(1) //TODO: convert to #pragma pack(push); #pragma pack(pop)
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
          int32_t setpoint;
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
                  msg.values.setpoint = (int32_t) setpoint; //Could use some rounding like (set>0)?(set+0.5):(set-0.5)
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
                Kp = msg.values.Kp;
                Ki = msg.values.Ki;
                Kd = msg.values.Kd;
                deadband = msg.values.deadband;
                IntegralLimit = msg.values.IntegralLimit;
                PWM_LIMIT = msg.values.PWMLimit;
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
    int64_t now = esp_timer_get_time();
    BaseType_t xHigherPriorityTaskWoken = pdFALSE;
    static uint32_t count;
    fbtime_valid = 0;         // Just for sanity checking afterwards

    if (gpio_get_level(FB360_PIN) == 1) // If high, pulse started or
    {                                   // cycle ended.
      if (!(count == 0 || count == 2))  // Abort if something messed up
      {                                 // our timing order.
        fbtime_valid = 0;
        count = 0;
        return;
      }
      
      fbtime_meas[count] = now;
      if (count == 2)         // Notify our task when we have collected 3 measurements
      {
        
        vTaskNotifyGiveFromISR( task_fb360_handle,
                                &xHigherPriorityTaskWoken );
        count = 0;
        fbtime_valid = 1;
      }

      count++;
    
    } else {
      
      if (count != 1)
      {
        fbtime_valid = 0;
        count = 0;
        return;
      }

      fbtime_valid = 0;
      fbtime_meas[0] = fbtime_meas[2];  // Make use of the last measurement for the new cycle
      fbtime_meas[count] = now;
      count++;
    }

    if (xHigherPriorityTaskWoken == pdTRUE)
      portYIELD_FROM_ISR();
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

    TickType_t xLastWakeTime; 
    
    vTaskDelay(pdMS_TO_TICKS(1000));

    ESP_ERROR_CHECK( pwm_set_duties(&duty) );
    ESP_ERROR_CHECK( pwm_start() );

    setpoint = 0;
    control_mode = 3;
    vel = 0;
    bool use_pv_for_derivative = 1;
    uint8_t control_mode_prev = 0;
    float pos_prev = 0;                               // For velocity computation
    float vel_unfilt = 0;
    float vel_filt = 0;
    float a = 0.1;                                    // Weight for velocity filtering
    float error_prev = 0, error = 0;                  // Control system variables
    float derivative_filt = 0, derivative = 0;
    float output = 0, integral = 0;
    float pv = 0, pv_prev = 0;                        // Process variable
    float w = 0.4;                                    // Weight for derivative filtering 
    
    int64_t loop_time_prev = 0;
    uint32_t loop_dt = 0;
    uint16_t default_T_loop = 10;           // Desired control loop period in ms
                                            // Value of 10 runs task @ 100Hz, twice the servo update rate (50)
                                            // If changed please verify the
                                            // scaling factors in the velocity
                                            // and derivative calculations.
    xLastWakeTime = xTaskGetTickCount();
    
    while(1) {
        if (loop_time_prev > 0)                                 // Update our time variables
          loop_dt = esp_timer_get_time() - loop_time_prev;
        if (loop_dt <= 0)                                       // Take care of dt
          loop_dt = default_T_loop*1000;                        // To us
        loop_time_prev = esp_timer_get_time();                  // Store time

        if (control_mode != control_mode_prev)                  // Handle on the fly control_mode change
        {
          error_prev = 0; integral = 0; derivative = 0; derivative_filt = 0; pv_prev = 0;
        }
        control_mode_prev = control_mode;

        vel_unfilt = (pos - pos_prev)/( ((float) loop_dt)/100000);    // In deg/s scaled by 10
        vel_filt = a*vel_unfilt + (1 - a)*vel_filt;
        vel = vel_filt;                                               // Here cast to int32
        pos_prev = pos;

        switch(control_mode){               // Calculate error
            case 0:
                error = setpoint-pos;
                pv = pos;
                break;
            case 1:
                error = setpoint-vel;         
                pv = vel;
                break;
            case 2:
                if (!(MIRRORED)) 
                {
                  if (setpoint < 0)
                  {
                    error = 0; pv = 0; error_prev = 0; integral = 0; derivative = 0; derivative_filt = 0; pv_prev = 0;
                  }else{
                    error = setpoint-dis;    
                    pv = dis;
                  }
                }else{
                  if (setpoint > 0)
                  {
                    error = 0; pv = 0; error_prev = 0; integral = 0; derivative = 0; derivative_filt = 0; pv_prev = 0;
                  }else{
                    error = setpoint+dis;
                    pv = -dis;
                  }
                }
                break;
            case 3:
                output = setpoint;
            default:
                error = 0; error_prev = 0; integral = 0; derivative = 0; derivative_filt = 0; pv = 0; pv_prev = 0;
        }

        if (use_pv_for_derivative)
          derivative = -(pv - pv_prev)/(loop_dt/1e4f);        // Scaled down by 100 (loop freq) to avoid output saturation, and negative to produce the same effect the error does.
        else
          derivative = (error - error_prev)/(loop_dt/1e4f);

        derivative_filt = w*derivative + (1 - w)*derivative_filt;
        integral += error*(loop_dt/1e6f);

        if (integral >= (float) IntegralLimit)        // Clamp integral
          integral = IntegralLimit;
        if (integral <= -((float) IntegralLimit))     // Damn if I know why the explicit cast is required,
          integral = -((float) IntegralLimit);        // else everything overflows to hell!
        
        if (control_mode!=3)
          output = Kp*error + Kd*derivative_filt + Ki*integral;        // Calculate PID result

        if (output >= (float) PWM_LIMIT)              // Clamp output
            output = PWM_LIMIT;            
        if (output < -((float) PWM_LIMIT))
            output = -((float) PWM_LIMIT);

        if (output == 0)                              // Servo pwm specifics
          duty = ZERO_SPEED;
        else if ( output > 0 )
          duty = ZERO_SPEED + PWM_OFFSET + output;
        else
          duty = ZERO_SPEED - PWM_OFFSET + output;

        ESP_ERROR_CHECK( pwm_set_duties(&duty) );
        ESP_ERROR_CHECK( pwm_start() );
        
        pwm = duty;
        error_prev = error;
        pv_prev = pv;

        vTaskDelayUntil( &xLastWakeTime, pdMS_TO_TICKS(default_T_loop) );
    } // End of task loop

    vTaskDelete(NULL);
}

void feedback360_task()                             // Keeps angle variable updated
{
    const int unitsFC = 360;                        // Units in a full circle
    const int dutyScale = 1000;                     // Scale duty cycle to 1/1000ths
    const int dcMin = 29;                           // Minimum duty cycle
    const int dcMax = 971;                          // Maximum duty cycle
    const int q2min = unitsFC/4;                    // For checking if in 1st quadrant
    const int q3max = q2min * 3;                    // For checking if in 4th quadrant
    const int cycle_period = 1100;                  // Cycle period in the servo manual

    int turns = 0;                                  // For tracking turns
    // dc is duty cycle, theta is 0 to 359 angle, thetaP is theta from previous
    // loop repetition, tHigh and tLow are the high and low signal times for
    // duty cycle calculations.
    float dc = 0, theta = 0, thetaP = 0;
    float tHigh = 0, tLow = 0, tCycle = 0;

    float pos_filt = 0;                             // Filtered position
    float pos_unfilt = 0;
    float w = 0.2;                                  // Filter weight

    int pos_tmp = 0, pos_offset = 0;
    bool first = true;

    while(1)                                    // Main task loop
    {
        while(1)                                  // Keep checking
        {
            ulTaskNotifyTake( pdTRUE,           /* Clear notification value. */
                              portMAX_DELAY );  /* Block indefinitely. */


            if ( fbtime_valid == 0 )    // If not valid wait for next measurement
            {
              continue; 
            }

            tHigh = fbtime_meas[1] - fbtime_meas[0];
            tLow  = fbtime_meas[2] - fbtime_meas[1];
            
            if(tHigh>0 && tLow>0){      // Should only go negative in case of a glitch or a timer overflow.
               tCycle = tHigh + tLow;
               if((tCycle > 1090) && (tCycle < 1110)) {  // If cycle time valid
                   break;                                // break from loop
               }
            }
        }

        dc = (dutyScale * tHigh) / tCycle;        // Calculate duty cycle

        // This gives a theta increasing float in the
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
        pos_tmp = (turns * unitsFC) + theta;

        if(first){
            first = false;
            pos_offset = pos_tmp;
            pos_unfilt = 0;
        }else{
            pos_unfilt = pos_tmp-pos_offset;
        }

        pos_filt = w*pos_unfilt + (1 - w)*pos_filt;
        pos = pos_filt;                           // Here cast to int32

        thetaP = theta;                           // Theta previous for next rep
    }

    vTaskDelete( NULL );
}

void app_main()
{
    taskENTER_CRITICAL(); // Disable while we set up the system

    gpio_config_t io_conf;
    //interrupt on every edge
    io_conf.intr_type = GPIO_INTR_ANYEDGE;
    //set as inputs
    io_conf.mode = GPIO_MODE_INPUT;
    //bit mask of the pins that we want to set
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
      // Turn off radio
      esp_wifi_disconnect();
      esp_wifi_stop();
      esp_wifi_deinit();

      //disable interrupt
      io_conf.intr_type = GPIO_INTR_DISABLE;
      //set as output
      io_conf.mode = GPIO_MODE_OUTPUT;
      //bit mask of the pins that we want to set
      io_conf.pin_bit_mask = (1ULL<<16);
      //disable pull-down mode
      io_conf.pull_down_en = 0;
      //disable pull-up mode
      io_conf.pull_up_en = 0;
      gpio_config(&io_conf);
      gpio_set_level(GPIO_NUM_16,0);

      // PWM Pin 5
      io_conf.intr_type = GPIO_INTR_DISABLE;
      io_conf.mode = GPIO_MODE_OUTPUT;
      io_conf.pin_bit_mask = (BIT(pwm_pin));
      io_conf.pull_down_en = 0;
      io_conf.pull_up_en = 0;
      gpio_config(&io_conf);
      gpio_set_level(pwm_pin,0);

      //Init PWM
      pwm_init(PWM_PERIOD, &duty, N_PWM_PINS, &pwm_pin);
      pwm_set_phases(&phase);

      // Debug pin 12
      io_conf.intr_type = GPIO_INTR_DISABLE;
      io_conf.mode = GPIO_MODE_OUTPUT;
      io_conf.pin_bit_mask = (GPIO_Pin_12);
      io_conf.pull_down_en = 0;
      io_conf.pull_up_en = 0;
      gpio_config(&io_conf);
      gpio_set_level(GPIO_NUM_12,0);
      

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
    xTaskCreate(command_task,"command_task",2048,NULL,3,NULL);
    printf("command_task started\n");
    xTaskCreate(feedback360_task,"feedback360_task",2048,NULL,4,&task_fb360_handle);
    printf("feedback360_task started\n");
    xTaskCreate(servo_task,"servo_task",2048,NULL,1,NULL);
    printf("servo_task started\n");

    taskEXIT_CRITICAL();    // Reenable interrupts
}
