#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/event_groups.h"
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
#include "driver/gpio.h"
#include "esp_timer.h"
#include "sdkconfig.h"
#include "esp_log.h"
#include "esp_event_loop.h"

#define OPTICAL_ENCODER_TIMEOUT 1
static int64_t t0 = 0, t1 = 0, t0_E0 = 0, t1_E0 = 0, t0_E1 = 0, t1_E1 = 0;
//#define MIRRORED
#define DEFAULT_SETPOINT 10
static int id = 6;
static int displacement_offset = 0;

static bool E0, E1;

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

static xQueueHandle gpio_evt_queue = NULL;

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

static const char *TAG = "wifi station";

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
            ESP_LOGI("displacement", "%d %d -> %d",E0,E1,status_frame.dis);
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

static void IRAM_ATTR gpio_isr_handler(void* arg)
{
    uint32_t gpio_num = (uint32_t) arg;
    xQueueSendFromISR(gpio_evt_queue, &gpio_num, NULL);
    if(gpio_get_level(gpio_num)==0)
        t0 = esp_timer_get_time();
    else
        t1 = esp_timer_get_time();
}

static void IRAM_ATTR gpio_isr_handler_E0(void* arg)
{
    t1_E0 = esp_timer_get_time();
    if((t1_E0-t0_E0)<OPTICAL_ENCODER_TIMEOUT)
      return;
    t0_E0 = t1_E0;
    uint32_t gpio_num = (uint32_t) arg;
    xQueueSendFromISR(gpio_evt_queue, &gpio_num, NULL);
    if(gpio_get_level(gpio_num)==0){
        E0 = false;
        if(E1){
          status_frame.dis++;
        }else{
          status_frame.dis--;
        }
    }else{
        E0 = true;
        if(!E1){
          status_frame.dis++;
        }else{
          status_frame.dis--;
        }
    }
}

static void IRAM_ATTR gpio_isr_handler_E1(void* arg)
{
    t1_E1 = esp_timer_get_time();
    if((t1_E1-t0_E1)<OPTICAL_ENCODER_TIMEOUT)
      return;
    t0_E1 = t1_E1;
    uint32_t gpio_num = (uint32_t) arg;
    xQueueSendFromISR(gpio_evt_queue, &gpio_num, NULL);
    if(gpio_get_level(gpio_num)==0){
        E1 = false;
        if(!E0){
          status_frame.dis++;
        }else{
          status_frame.dis--;
        }
    }else{
        E1 = true;
        if(E0){
          status_frame.dis++;
        }else{
          status_frame.dis--;
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

    //
    ledc_set_duty(LEDC_HIGH_SPEED_MODE, LEDC_CHANNEL_0, zeroSpeed);
    ledc_update_duty(LEDC_HIGH_SPEED_MODE, LEDC_CHANNEL_0);
//    int pos = 0;
//
//    for(int i=0;i<32768;i+=10){
//        ESP_LOGI("duty", "duty = %d", i);
//        ledc_set_duty(LEDC_HIGH_SPEED_MODE, LEDC_CHANNEL_0, i);
//        ledc_update_duty(LEDC_HIGH_SPEED_MODE, LEDC_CHANNEL_0);
//        if(status_frame.pos==pos)
//            vTaskDelay(pdMS_TO_TICKS(1000));
//        else
//            vTaskDelay(pdMS_TO_TICKS(100));
//
//        pos = status_frame.pos;
//    }

    vTaskDelay(pdMS_TO_TICKS(1000));

    control_frame.mode = 2;
    control_frame.Kp = 1;
    control_frame.Ki = 0;
    control_frame.Kd = 0;

    status_frame.vel = 0;
    float error_prev = 0;
    while(1) {
        float error, output;             // Control system variables
        switch(control_frame.mode){
            case 0:
                error = status_frame.pos-command_frame.setpoint;         // Calculate error
                break;
            case 1:
                error = status_frame.vel-command_frame.setpoint;         // Calculate error
                break;
            case 2:
                if(command_frame.setpoint>=0) {
#ifndef MIRRORED
                    error = status_frame.dis - command_frame.setpoint;         // Calculate error
#else
                    error = -(status_frame.dis - command_frame.setpoint);         // Calculate error
#endif
                }else
                    error = 0;
                break;
            default:
                error = 0;
        }

        output = error * control_frame.Kp + (error-error_prev)*control_frame.Kd;                 // Calculate proportional

        if(output > 50)
            output = 50;            // Clamp output
        if(output < -50)
            output = -50;
        ledc_set_duty(LEDC_HIGH_SPEED_MODE, LEDC_CHANNEL_0, zeroSpeed+output);
        ledc_update_duty(LEDC_HIGH_SPEED_MODE, LEDC_CHANNEL_0);
        status_frame.pwm = output;
        vTaskDelay(pdMS_TO_TICKS(100));
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

    int pos = 0, pos_offset = 0;
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
            pos = (turns * unitsFC) + theta;
        else if(turns <  0)
            pos = ((turns + 1) * unitsFC) - (unitsFC - theta);

        if(first){
            first = false;
            pos_offset = pos;
            status_frame.pos = 0;
        }else{
            status_frame.pos = pos-pos_offset;
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

    wifi_init_sta();
//    xTaskCreate(&displacement_task,"displacement_task",2048,NULL,1,NULL);
//    printf("displacement_task started\n");
    xTaskCreate(&feedback360_task,"feedback360_task",2048,NULL,4,NULL);
    printf("feedback360_task started\n");
    xTaskCreate(&status_task,"status_task",2048,NULL,5,NULL);
    printf("status_task started\n");
    xTaskCreate(&command_task,"command_task",2048,NULL,3,NULL);
    printf("command_task started\n");
    xTaskCreate(&servo_task,"servo_task",2048,NULL,1,NULL);
    printf("servo_task started\n");
}
