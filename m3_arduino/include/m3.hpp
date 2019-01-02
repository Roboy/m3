#ifndef HEADER_N
#define HEADER_N
#include <Wire.h>
#include <A1335.h>
#include <Servo.h>
#include <ESP8266WiFi.h>
#include <ros.h>
#include <std_msgs/Int8.h>
#include <roboy_middleware_msgs/MotorCommand.h>
#include <roboy_middleware_msgs/ControlMode.h>
#include <roboy_middleware_msgs/MotorStatus.h>
#define SPINDLE_RADIUS 0.0057
#define POSITION 0
#define VELOCITY 1
#define DISPLACEMENT 2
#define FORCE 3

class M3{
  public:
      M3(uint8_t deviceId, int servoPin, int analogPin);
      void update();
      void updateController();
      void printStatus();
      void sendStatus();
      void init();
      static void MotorCommand(const roboy_middleware_msgs::MotorCommand& msg);
      static void ControlMode(const std_msgs::Int8& msg);
  public:
    static int32_t id;
    int32_t pwmRef = 90;
    int32_t angle = 0;
    static int32_t angleAbsolute;
    int32_t angleAbsolute_prev = 0;
    int32_t t0 = 0, t1 = 0;
    static int32_t angleAbsoluteVelocity;
    int32_t position = 0;
    int32_t rev_counter = 0;
    static int32_t displacement;
    int32_t force = 0;
    static int setPoint;
    static float Kp, Kd;
    Servo servo;
    A1335 a1335;
    int analogPin, servoPin;
    const float springConstant = 5.241;
    static int cm;
    ros::NodeHandle nh;
    ros::Subscriber<roboy_middleware_msgs::MotorCommand> *motor_command;
    ros::Subscriber<std_msgs::Int8> *control_mode;
    ros::Publisher *motor_status;
    roboy_middleware_msgs::MotorStatus status_msg;
    const char* ssid = "roboy";
    const char* password = "wiihackroboy";
};

#endif
