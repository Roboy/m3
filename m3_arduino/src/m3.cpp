#include "m3.hpp"

int M3::cm = 0;
int M3::setPoint = 0;
int M3::id = 0;
int M3::angleAbsolute = 0;
int M3::angleAbsoluteVelocity = 0;
int M3::displacement = 0;

M3::M3(uint8_t deviceId, int servoPin, int analogPin):servoPin(servoPin),analogPin(analogPin){
    Wire.begin();
    a1335.start(deviceId);
    servo.attach(servoPin);
}
void M3::init(){
    Serial.print("Ready! Use ");
    Serial.print(WiFi.localIP());
    Serial.println(" to access client");
    // connect to an AP
    IPAddress server(192,168,0,227);
    nh.getHardware()->setConnection(server,11411);
    nh.initNode();
    motor_status = new ros::Publisher("roboy/middleware/MotorStatus",&status_msg);
    status_msg.angle_length = 1;
    status_msg.angle = new roboy_middleware_msgs::MotorStatus::_angle_type[1];
    status_msg.pwm_ref_length = 1;
    status_msg.pwm_ref = new roboy_middleware_msgs::MotorStatus::_pwm_ref_type[1];
    status_msg.current_length = 1;
    status_msg.current = new roboy_middleware_msgs::MotorStatus::_current_type[1];
    status_msg.displacement_length = 1;
    status_msg.displacement = new roboy_middleware_msgs::MotorStatus::_displacement_type[1];
    status_msg.position_length = 1;
    status_msg.position = new roboy_middleware_msgs::MotorStatus::_position_type[1];
    status_msg.velocity_length = 1;
    status_msg.velocity = new roboy_middleware_msgs::MotorStatus::_velocity_type[1];
    nh.advertise(*motor_status);
    motor_command = new ros::Subscriber<roboy_middleware_msgs::MotorCommand>("roboy/middleware/MotorCommand", &MotorCommand);
    nh.subscribe(*motor_command);
    id = WiFi.localIP()[3];
    status_msg.id = id;
    control_mode = new ros::Subscriber<std_msgs::Int8>("roboy/middleware/ControlMode", &ControlMode);
    nh.subscribe(*control_mode);
}
void M3::sendStatus(){
    status_msg.angle[0] = angle;
    status_msg.pwm_ref[0] = pwmRef;
    status_msg.current[0] = 0;
    status_msg.displacement[0] = displacement;
    status_msg.position[0] = angleAbsolute;
    status_msg.velocity[0] = angleAbsoluteVelocity;
    motor_status->publish(&status_msg);
}
void  M3::MotorCommand(const roboy_middleware_msgs::MotorCommand& msg) {
        if(msg.id!=id)
            return;
        setPoint = msg.set_points[0];
        // Serial.println(msg.set_points[0]);
    }
void M3::ControlMode(const std_msgs::Int8& msg) {
    if(msg.data>=0 && msg.data<=2){
        cm = msg.data;
        switch(cm){
            case POSITION:
                setPoint = angleAbsolute;
                Serial.println("changing control mode to POSITION");
                break;
            case VELOCITY:
                setPoint = 0;
                Serial.println("changing control mode to VELOCITY");
                break;
            case DISPLACEMENT:
                setPoint = 0;
                Serial.println("changing control mode to DISPLACMENT");
                break;
        }
    }else{
        Serial.println("Invalid control mode requested, available POSITION(0), VELOCITY(1), DISPLACEMENT(2)");
    }
}
void M3::update(){
    static int counter = 0;
    int32_t val = a1335.readAngleRaw();
    if(angle>3500 && val<500){
      rev_counter++;
    }
    if(angle<500 && val>3500){
      rev_counter--;
    }
    angle = val;
    angleAbsolute = rev_counter*4096 + angle;
    displacement = analogRead(analogPin);
    force = displacement*20*springConstant;
    position = angleAbsolute;
}
void M3::updateController(){
  switch(cm){
      case POSITION:{
          static int32_t error_prev = 0;
          int32_t error = (setPoint-angleAbsolute);
          float control = Kp*error + Kd*(error-error_prev);
          if(control>20){
            control = 20;
          }else if(control < -20){
            control = -20;
          }
          pwmRef = 90 + control;
          servo.write(pwmRef);
        break;
      }
      case VELOCITY:{
          static int32_t error_prev = 0;
          int32_t error = (setPoint-angleAbsoluteVelocity);
          int32_t control = Kp*error + Kd*(error-error_prev);
          if(control>20){
            control = 20;
          }else if(control < -20){
            control = -20;
          }
          pwmRef = 90 + control;
          servo.write(pwmRef);
        break;
      }
      case DISPLACEMENT:{
          static int32_t error_prev = 0;
          int32_t error = (setPoint-force);
          int32_t control = Kp*error + Kd*(error-error_prev);
          if(control>20){
            control = 20;
          }else if(control < -20){
            control = -20;
          }
          pwmRef = 90 + control;
          servo.write(pwmRef);
        break;
      }
  }

}
void M3::printStatus(){
    Serial.print("angle: ");
    Serial.println(angle);
    Serial.print("angleAbsolute: ");
    Serial.println(angleAbsolute);
    Serial.print("displacement: ");
    Serial.println(displacement);
    Serial.print("position: ");
    Serial.println(position);
    Serial.print("force: ");
    Serial.println(force);
    Serial.print("pwmRef: ");
    Serial.println(pwmRef);
    Serial.print("rev_counter: ");
    Serial.println(rev_counter);
}
