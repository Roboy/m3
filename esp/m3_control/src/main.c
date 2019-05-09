/*
Code is adapted from
https://github.com/nkolban/esp32-snippets/blob/master/hardware/servos/servoSweep.c
*/

#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/queue.h"
#include "driver/ledc.h"
#include "driver/gpio.h"
#include "esp_timer.h"
#include "sdkconfig.h"
#include "esp_log.h"

static int64_t t0 = 0, t1 = 0;

static char tag[] = "servo1";

static xQueueHandle gpio_evt_queue = NULL;

#define SSID "why-fi"
#define PASSPHARSE "wiihackroboy"

static EventGroupHandle_t wifi_event_group;
const int CONNECTED_BIT = BIT0;

void wifi_connect(){
    wifi_config_t cfg = {
            .sta = {
                    .ssid = SSID,
                    .password = PASSPHARSE,
            },
    };
    ESP_ERROR_CHECK( esp_wifi_disconnect() );
    ESP_ERROR_CHECK( esp_wifi_set_config(ESP_IF_WIFI_STA, &cfg) );
    ESP_ERROR_CHECK( esp_wifi_connect() );
}

static esp_err_t event_handler(void *ctx, system_event_t *event)
{
    switch(event->event_id) {
        case SYSTEM_EVENT_STA_START:
            wifi_connect();
            break;
        case SYSTEM_EVENT_STA_GOT_IP:
            xEventGroupSetBits(wifi_event_group, CONNECTED_BIT);
            break;
        case SYSTEM_EVENT_STA_DISCONNECTED:
            esp_wifi_connect();
            xEventGroupClearBits(wifi_event_group, CONNECTED_BIT);
            break;
        default:
            break;
    }
    return ESP_OK;
}

static void initialise_wifi(void)
{
    esp_log_level_set("wifi", ESP_LOG_NONE); // disable wifi driver logging
    tcpip_adapter_init();
    wifi_init_config_t cfg = WIFI_INIT_CONFIG_DEFAULT();
    ESP_ERROR_CHECK( esp_wifi_init(&cfg) );
    ESP_ERROR_CHECK( esp_wifi_set_mode(WIFI_MODE_STA) );
    ESP_ERROR_CHECK( esp_wifi_start() );
}

void printWiFiIP(void *pvParam){
    printf("printWiFiIP task started \n");
    while(1){
        xEventGroupWaitBits(wifi_event_group,CONNECTED_BIT,true,true,portMAX_DELAY);
        tcpip_adapter_ip_info_t ip_info;
        ESP_ERROR_CHECK(tcpip_adapter_get_ip_info(TCPIP_ADAPTER_IF_STA, &ip_info));
        printf("IP :  %s\n", ip4addr_ntoa(&ip_info.ip));
    }
}

static void IRAM_ATTR gpio_isr_handler(void* arg)
{
    uint32_t gpio_num = (uint32_t) arg;
    xQueueSendFromISR(gpio_evt_queue, &gpio_num, NULL);
    if(gpio_get_level(gpio_num)==0)
        t0 = esp_timer_get_time();
    else
        t1 = esp_timer_get_time();
//    printf("t0 %d t1 %d\n", (int)t0,(int)t1);
}

static void gpio_task_example(void* arg)
{
    uint32_t io_num;
    for(;;) {
        if(xQueueReceive(gpio_evt_queue, &io_num, portMAX_DELAY)) {


        }
    }
}

void sweepServo_task(void *ignore) {
    int bitSize         = 15;
    int minValue        = 2000;  // micro seconds (uS)
    int maxValue        = 3200; // micro seconds (uS)
    int sweepDuration   = 5000; // milliseconds (ms)
    int duty            = 2000 ;
    int direction       = 1; // 1 = up, -1 = down
    int valueChangeRate = 20; // msecs

    ESP_LOGD(tag, ">> task_servo1");
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

    int changesPerSweep = sweepDuration / valueChangeRate;// 1500/20 -> 75
    int changeDelta = (maxValue-minValue) / changesPerSweep;// 2000/75 -> 26
    int i;
    ESP_LOGI(tag, "sweepDuration: %d seconds", sweepDuration);
    ESP_LOGI(tag, "changesPerSweep: %d", changesPerSweep);
    ESP_LOGI(tag, "changeDelta: %d", changeDelta);
    ESP_LOGI(tag, "valueChangeRate: %d", valueChangeRate);
    while(1) {
        for (i=0; i<changesPerSweep; i++) {
            if (direction > 0) {
                duty += changeDelta;
            } else {
                duty -= changeDelta;
            }
            ledc_set_duty(LEDC_HIGH_SPEED_MODE, LEDC_CHANNEL_0, duty);
            ledc_update_duty(LEDC_HIGH_SPEED_MODE, LEDC_CHANNEL_0);
            vTaskDelay(valueChangeRate/portTICK_PERIOD_MS);
//            ESP_LOGI(tag, "%d", duty);
        }
        direction = -direction;
//        ESP_LOGI(tag, "Direction now %d", direction);
    } // End loop forever

    vTaskDelete(NULL);
}

static void periodic_timer_callback(void* arg){

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
    int dc, theta, thetaP, tHigh = 1200, tLow = 0, angle = 0;

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
        ESP_LOGI("timer", "tCycle = %d, tLow = %d tHigh = %d", tCycle, tLow, tHigh);
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
            angle = (turns * unitsFC) + theta;
        else if(turns <  0)
            angle = ((turns + 1) * unitsFC) - (unitsFC - theta);

        ESP_LOGI("timer", "tCycle = %d, tLow = %d tHigh = %d angle = %d", tCycle, tLow, tHigh, angle);

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

    ESP_ERROR_CHECK( esp_event_loop_init(event_handler, NULL) );
    wifi_event_group = xEventGroupCreate();
    initialise_wifi();
    xTaskCreate(&printWiFiIP,"printWiFiIP",2048,NULL,5,NULL);
//    xTaskCreate(&sweepServo_task,"sweepServo_task",2048,NULL,5,NULL);
//    printf("servo sweep task started\n");
//    xTaskCreate(&feedback360_task,"feedback360_task",2048,NULL,5,NULL);
//    printf("feedback 360 task started\n");

}