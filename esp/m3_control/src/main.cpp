#include "control.hpp"
#include "esp_log.h"
#include "nvs_flash.h"

extern "C" {
    void app_main()
    {
        gpio_config_t io_conf;
        //disable interrupt
        io_conf.intr_type = gpio_int_type_t(GPIO_PIN_INTR_ANYEDGE);
        //set as output mode
        io_conf.mode = GPIO_MODE_INPUT;
        //bit mask of the pins that you want to set,e.g.GPIO18/19
        io_conf.pin_bit_mask = (1ULL<<15);
        //disable pull-down mode
        io_conf.pull_down_en = GPIO_PULLDOWN_DISABLE;
        //disable pull-up mode
        io_conf.pull_up_en = GPIO_PULLUP_DISABLE;
        gpio_config(&io_conf);

        //create a queue to handle gpio event from isr
        gpio_evt_queue = xQueueCreate(10, sizeof(uint32_t));

        //install gpio isr service
        gpio_install_isr_service(0);
        //hook isr handler for specific gpio pin
        gpio_isr_handler_add(GPIO_NUM_15, gpio_isr_handler, (void*) 15);
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
}
