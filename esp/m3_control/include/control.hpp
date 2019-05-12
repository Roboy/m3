#ifndef M3_CONTROL_CONTROL_HPP
#define M3_CONTROL_CONTROL_HPP

#include "communication.hpp"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/event_groups.h"
#include "sys/time.h"
#include <stdio.h>
#include "driver/ledc.h"
#include "driver/gpio.h"
#include "esp_timer.h"
#include "sdkconfig.h"
#include "esp_log.h"

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

void servo_task(void *ignore) {
    int minValue        = 2000;  // micro seconds (uS)
    int maxValue        = 3200; // micro seconds (uS)
    int zeroSpeed       = minValue+(maxValue-minValue)/2;
    int duty            = 2000 ;

    ledc_timer_config_t timer_conf;
    timer_conf.duty_resolution    = LEDC_TIMER_15_BIT;
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
    status_frame.dis = 0;

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

void feedback360_task(void *ignore)                            // Cog keeps angle variable updated
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

    gpio_num_t io_num = GPIO_NUM_5;

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

#endif //M3_CONTROL_CONTROL_HPP
