#ifndef M3_CONTROL_COMMUNICATION_HPP
#define M3_CONTROL_COMMUNICATION_HPP

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/event_groups.h"
#include "esp_system.h"
#include "esp_wifi.h"
#include "esp_event.h"
#include "esp_log.h"
#include "sys/socket.h"
#include "lwip/err.h"
#include "lwip/sys.h"

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

#define ESP_WIFI_SSID      "roboy"
#define ESP_WIFI_PASS      "wiihackroboy"
#define ESP_MAXIMUM_RETRY  10
#define HOST_IP_ADDR "192.168.0.224"
#define STATUS_PORT 8000
#define COMMAND_PORT 8001
static EventGroupHandle_t s_wifi_event_group;
const int WIFI_CONNECTED_BIT = BIT0;
static int s_retry_num = 0;

void command_task(void *ignore);

void status_task(void *ignore);

void event_handler(void* arg, esp_event_base_t event_base,
                          int32_t event_id, void* event_data);

void wifi_init_sta();

#endif //M3_CONTROL_COMMUNICATION_HPP
