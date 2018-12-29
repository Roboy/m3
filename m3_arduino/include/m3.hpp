#pragma once
#include <Wire.h>
#include <A1335.h>
#include <Servo.h>
#include <ESP8266WiFi.h>
#include <ros.h>
#include <roboy_middleware_msgs/MotorCommand.h>
#include <roboy_middleware_msgs/ControlMode.h>
#include <roboy_middleware_msgs/MotorStatus.h>
#define SPINDLE_RADIUS 0.0057
#define POSITION 0
#define VELOCITY 1
#define DISPLACEMENT 2

class WiFiHardware {

  public:
  WiFiHardware() {};

  void init() {
    // do your initialization here. this probably includes TCP server/client setup
    IPAddress server(192, 168, 1, 100); // ip of your ROS server
    client.connect(server, 11411);
  }

  // read a byte from the serial port. -1 = failure
  int read() {
    // implement this method so that it reads a byte from the TCP connection and returns it
    //  you may return -1 is there is an error; for example if the TCP connection is not open
    return client.read();         //will return -1 when it will works
  }

  // write data to the connection to ROS
  void write(uint8_t* data, int length) {
    // implement this so that it takes the arguments and writes or prints them to the TCP connection
    for(int i=0; i<length; i++)
      client.write(data[i]);
  }

  // returns milliseconds since start of program
  unsigned long time() {
     return millis(); // easy; did this one for you
  }
    int status = WL_IDLE_STATUS;
    WiFiClient client;
};

class M3{
  public:
      M3(uint8_t deviceId, int servoPin, int analogPin);
      void update();
      void updateController();
      void printStatus();
      void sendStatus();
      void initWifi();
      static void MotorCommand(const roboy_middleware_msgs::MotorCommand& msg);
      static void ControlMode(const roboy_middleware_msgs::ControlModeRequest& req,
                        roboy_middleware_msgs::ControlModeResponse& res);
  public:
    static int32_t id;
    int32_t pwmRef = 90;
    int32_t angle = 0;
    int32_t angleAbsolute = 0;
    int32_t angleAbsoluteVelocity = 0;
    int32_t position = 0;
    int32_t rev_counter = 0;
    int32_t displacement = 0;
    int32_t force = 0;
    static int setPoint;
    int32_t Kp = 1, Kd = 0;
    Servo servo;
    A1335 a1335;
    int analogPin, servoPin;
    const float springConstant = 5.241;
    static int cm;
    ros::NodeHandle_<WiFiHardware> nh;
    ros::Subscriber<roboy_middleware_msgs::MotorCommand> *motor_command;
    ros::Publisher *motor_status;
    roboy_middleware_msgs::MotorStatus status_msg;
    ros::ServiceServer<roboy_middleware_msgs::ControlModeRequest,
               roboy_middleware_msgs::ControlModeResponse> *control_mode;
    const char* ssid = "roboy";
    const char* password = "wiihackroboy";
};
