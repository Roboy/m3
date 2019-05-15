#ifndef M3_CONTROL_CONTROL_HPP
#define M3_CONTROL_CONTROL_HPP

#include "communication.hpp"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/event_groups.h"
#include "sys/time.h"
#include <stdio.h>
#include <driver/ledc.h>
#include "esp_timer.h"
#include "sdkconfig.h"
#include "esp_log.h"
#include "driver/gpio.h"
#include "driver/adc.h"
#include "esp_adc_cal.h"

#define DEFAULT_VREF    1100        //Use adc2_vref_to_gpio() to obtain a better estimate
#define NO_OF_SAMPLES   64          //Multisampling

static esp_adc_cal_characteristics_t *adc_chars;
static const adc1_channel_t channel = ADC_CHANNEL_6;     //GPIO34 if ADC1, GPIO14 if ADC2
static const adc_atten_t atten = ADC_ATTEN_DB_0;
static const adc_unit_t unit = ADC_UNIT_1;

static xQueueHandle gpio_evt_queue = NULL;
static int64_t t0 = 0, t1 = 0;

static void IRAM_ATTR gpio_isr_handler(void* arg)
{
    gpio_num_t *gpio_num = reinterpret_cast<gpio_num_t*>(arg);
    xQueueSendFromISR(gpio_evt_queue, &gpio_num, NULL);
    if(gpio_get_level(*gpio_num)==0)
        t0 = esp_timer_get_time();
    else
        t1 = esp_timer_get_time();
}

void displacement_task(void *ignore);

void servo_task(void *ignore);

void feedback360_task(void *ignore);

#endif //M3_CONTROL_CONTROL_HPP
