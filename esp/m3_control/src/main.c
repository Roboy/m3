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
#include "driver/ledc.h"
#include "driver/gpio.h"
#include "esp_timer.h"
#include "sdkconfig.h"
#include "esp_log.h"

static int64_t t0 = 0, t1 = 0;

static char tag[] = "servo1";

struct{
    int32_t motor;
    int32_t pos;
    int32_t vel;
    int32_t displacement;
    int32_t pwm;
}status_frame;

struct{
    uint8_t motor:8;
    uint8_t command:8;
    int32_t setpoint:32;
}command_frame;

static xQueueHandle gpio_evt_queue = NULL;

#define HOST_IP_ADDR "192.168.0.224"
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

static int s_retry_num = 0;

static void command_task(void *pvParameters)
{
    char rx_buffer[128];
    int addr_family;
    int ip_protocol;

    command_frame.setpoint = 0;

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
            if (len == 6) {
//                memcpy(command_frame.data,rx_buffer,6);
                ESP_LOGI(TAG, "Received command_frame");
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
    status_frame.motor = 0;
    status_frame.pos = 0;
    status_frame.vel = 0xffffff01;
    status_frame.displacement = 0xffffff02;

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
            int err = sendto(sock, (char*)&status_frame, sizeof(status_frame), 0, (struct sockaddr *)&dest_addr, sizeof(dest_addr));
            if (err < 0) {
                ESP_LOGE(TAG, "Error occurred during sending: errno %d", errno);
                break;
            }
            ESP_LOGD(TAG, "Message sent");
            vTaskDelay(10 / portTICK_PERIOD_MS);
        }

        if (sock != -1) {
            ESP_LOGE(TAG, "Shutting down socket and restarting...");
            shutdown(sock, 0);
            close(sock);
        }
    }
    vTaskDelete(NULL);
}

static void event_handler(void* arg, esp_event_base_t event_base,
                          int32_t event_id, void* event_data)
{
    if (event_base == WIFI_EVENT && event_id == WIFI_EVENT_STA_START) {
        esp_wifi_connect();
    } else if (event_base == WIFI_EVENT && event_id == WIFI_EVENT_STA_DISCONNECTED) {
        if (s_retry_num < EXAMPLE_ESP_MAXIMUM_RETRY) {
            esp_wifi_connect();
            xEventGroupClearBits(s_wifi_event_group, WIFI_CONNECTED_BIT);
            s_retry_num++;
            ESP_LOGI(TAG, "retry to connect to the AP");
        }
        ESP_LOGI(TAG,"connect to the AP fail");
    } else if (event_base == IP_EVENT && event_id == IP_EVENT_STA_GOT_IP) {
        ip_event_got_ip_t* event = (ip_event_got_ip_t*) event_data;
        ESP_LOGI(TAG, "got ip:%s",
                 ip4addr_ntoa(&event->ip_info.ip));
        s_retry_num = 0;
        xEventGroupSetBits(s_wifi_event_group, WIFI_CONNECTED_BIT);
    }
}

void wifi_init_sta()
{
    s_wifi_event_group = xEventGroupCreate();

    tcpip_adapter_init();

    ESP_ERROR_CHECK(esp_event_loop_create_default());

    wifi_init_config_t cfg = WIFI_INIT_CONFIG_DEFAULT();
    ESP_ERROR_CHECK(esp_wifi_init(&cfg));

    ESP_ERROR_CHECK(esp_event_handler_register(WIFI_EVENT, ESP_EVENT_ANY_ID, &event_handler, NULL));
    ESP_ERROR_CHECK(esp_event_handler_register(IP_EVENT, IP_EVENT_STA_GOT_IP, &event_handler, NULL));

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

void servo_task(void *ignore) {
    int minValue        = 2000;  // micro seconds (uS)
    int maxValue        = 3200; // micro seconds (uS)
    int zeroSpeed       = minValue+(maxValue-minValue)/2;
    int duty            = 2000 ;

    ledc_timer_config_t timer_conf;
    timer_conf.bit_num    = LEDC_TIMER_15_BIT;
    timer_conf.freq_hz    = 50;
    timer_conf.speed_mode = LEDC_HIGH_SPEED_MODE;
    timer_conf.timer_num  = LEDC_TIMER_0;
    ledc_timer_config(&timer_conf);

    ledc_channel_config_t ledc_conf;
    ledc_conf.channel    = LEDC_CHANNEL_0;
    ledc_conf.duty       = duty;
    ledc_conf.gpio_num   = 16;
    ledc_conf.intr_type  = LEDC_INTR_DISABLE;
    ledc_conf.speed_mode = LEDC_HIGH_SPEED_MODE;
    ledc_conf.timer_sel  = LEDC_TIMER_0;
    ledc_channel_config(&ledc_conf);

    status_frame.pos = 0;
    status_frame.vel = 0;
    status_frame.displacement = 0;

    int Kp = 10;                          // Proportional constant
    while(1) {
        int errorAngle, output;             // Control system variables
        errorAngle = status_frame.pos-command_frame.setpoint;         // Calculate error
        output = errorAngle * Kp;                 // Calculate proportional
        if(output > 500) output = 500;            // Clamp output
        if(output < -500) output = -500;
        ledc_set_duty(LEDC_HIGH_SPEED_MODE, LEDC_CHANNEL_0, zeroSpeed+output);
        ledc_update_duty(LEDC_HIGH_SPEED_MODE, LEDC_CHANNEL_0);
        status_frame.pwm = output;
        vTaskDelay(20/portTICK_PERIOD_MS);
//        for (i=0; i<changesPerSweep; i++) {
//            if (direction > 0) {
//                duty += changeDelta;
//            } else {
//                duty -= changeDelta;
//            }
//            ledc_set_duty(LEDC_HIGH_SPEED_MODE, LEDC_CHANNEL_0, duty);
//            ledc_update_duty(LEDC_HIGH_SPEED_MODE, LEDC_CHANNEL_0);
//            vTaskDelay(valueChangeRate/portTICK_PERIOD_MS);
////            ESP_LOGI(tag, "%d", duty);
//        }
//        direction = -direction;
//        ESP_LOGI(tag, "Direction now %d", direction);
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

    int io_num = 5;

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
            status_frame.pos = (turns * unitsFC) + theta;
        else if(turns <  0)
            status_frame.pos = ((turns + 1) * unitsFC) - (unitsFC - theta);

        ESP_LOGI("timer", "angle = %d", status_frame.pos);

        thetaP = theta;                           // Theta previous for next rep
    }
}

void app_main()
{
    gpio_config_t io_conf;
    //disable interrupt
    io_conf.intr_type = GPIO_PIN_INTR_ANYEDGE;
    //set as output mode
    io_conf.mode = GPIO_MODE_INPUT;
    //bit mask of the pins that you want to set,e.g.GPIO18/19
    io_conf.pin_bit_mask = (1ULL<<15);
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
    gpio_isr_handler_add(15, gpio_isr_handler, (void*) 15);
    //Initialize NVS
    esp_err_t ret = nvs_flash_init();
    if (ret == ESP_ERR_NVS_NO_FREE_PAGES || ret == ESP_ERR_NVS_NEW_VERSION_FOUND) {
        ESP_ERROR_CHECK(nvs_flash_erase());
        ret = nvs_flash_init();
    }
    ESP_ERROR_CHECK(ret);
    nvs_flash_init();
    wifi_init_sta();
    xTaskCreate(&servo_task,"servo_task",2048,NULL,5,NULL);
    printf("servo_task started\n");
    xTaskCreate(&feedback360_task,"feedback360_task",2048,NULL,5,NULL);
    printf("feedback360_task started\n");
    xTaskCreate(&status_task,"status_task",2048,NULL,5,NULL);
    printf("status_task started\n");
    xTaskCreate(&command_task,"command_task",2048,NULL,5,NULL);
    printf("command_task started\n");
//    xTaskCreate(&receiveCommand_task,"receiveCommand_task",2048,NULL,5,NULL);
//    printf("receiveCommand_task started\n");
}