#include "communication.hpp"

void command_task(void *ignore)
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
            ESP_LOGE("UDP", "Unable to create socket: errno %d", errno);
            break;
        }
        local_addr.sin_family = AF_INET;
        local_addr.sin_addr.s_addr = htonl(INADDR_ANY);
        local_addr.sin_port = htons(COMMAND_PORT);
        if (bind(sock, (struct sockaddr *) &local_addr, sizeof local_addr) < 0) {
            ESP_LOGE("UDP", "bind port error");
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
                ESP_LOGI("UDP", "Received command_frame");
            }
        }

        if (sock != -1) {
            ESP_LOGE("UDP", "Shutting down socket and restarting...");
            shutdown(sock, 0);
            close(sock);
        }
    }
    vTaskDelete(NULL);
}

void status_task(void *ignore)
{
    char addr_str[128];
    int addr_family;
    int ip_protocol;
    status_frame.motor = 0;
    status_frame.pos = 0;
    status_frame.vel = 0;
    status_frame.dis = 0;

    while (1) {

        struct sockaddr_in dest_addr;
        dest_addr.sin_addr.s_addr = inet_addr(HOST_IP_ADDR);
        dest_addr.sin_family = AF_INET;
        dest_addr.sin_port = htons(STATUS_PORT);
        addr_family = AF_INET;
        ip_protocol = IPPROTO_IP;
        inet_ntoa_r(dest_addr.sin_addr, addr_str, sizeof(addr_str) - 1);

        int sock = socket(addr_family, SOCK_DGRAM, ip_protocol);
        if (sock < 0) {
            ESP_LOGE("UDP", "Unable to create socket: errno %d", errno);
            break;
        }

        while (1) {
            int err = sendto(sock, (char*)&status_frame, sizeof(status_frame), 0, (struct sockaddr *)&dest_addr, sizeof(dest_addr));
            if (err < 0) {
                ESP_LOGE("UDP", "Error occurred during sending: errno %d", errno);
                break;
            }
            ESP_LOGD("UDP", "Message sent");
            vTaskDelay(10 / portTICK_PERIOD_MS);
        }

        if (sock != -1) {
            ESP_LOGE("UDP", "Shutting down socket and restarting...");
            shutdown(sock, 0);
            close(sock);
        }
    }
    vTaskDelete(NULL);
}

void event_handler(void* arg, esp_event_base_t event_base,
                          int32_t event_id, void* event_data)
{
    if (event_base == WIFI_EVENT && event_id == WIFI_EVENT_STA_START) {
        esp_wifi_connect();
    } else if (event_base == WIFI_EVENT && event_id == WIFI_EVENT_STA_DISCONNECTED) {
        if (s_retry_num < ESP_MAXIMUM_RETRY) {
            esp_wifi_connect();
            xEventGroupClearBits(s_wifi_event_group, WIFI_CONNECTED_BIT);
            s_retry_num++;
            ESP_LOGI("UDP", "retry to connect to the AP");
        }
        ESP_LOGI("UDP","connect to the AP fail");
    } else if (event_base == IP_EVENT && event_id == IP_EVENT_STA_GOT_IP) {
        ip_event_got_ip_t* event = (ip_event_got_ip_t*) event_data;
        ESP_LOGI("UDP", "got ip:%s",
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
                    {.ssid = ESP_WIFI_SSID},
                    {.password = ESP_WIFI_PASS}
            },
    };
    ESP_ERROR_CHECK(esp_wifi_set_mode(WIFI_MODE_STA) );
    ESP_ERROR_CHECK(esp_wifi_set_config(ESP_IF_WIFI_STA, &wifi_config) );
    ESP_ERROR_CHECK(esp_wifi_start() );

    ESP_LOGI("UDP", "wifi_init_sta finished.");
    ESP_LOGI("UDP", "connect to ap SSID:%s password:%s",
             ESP_WIFI_SSID, ESP_WIFI_PASS);
}