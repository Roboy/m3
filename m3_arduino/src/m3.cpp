#include "m3.hpp"

int M3::cm = 0;
int M3::setPoint = 0;
int M3::id = 0;

M3::M3(uint8_t deviceId, int servoPin, int analogPin):servoPin(servoPin),analogPin(analogPin){
    Wire.begin();
    a1335.start(deviceId);
    servo.attach(servoPin);
    motor_command = new ros::Subscriber<roboy_middleware_msgs::MotorCommand>("roboy/middleware/MotorCommand", &MotorCommand);
    nh.initNode();
    nh.subscribe(*motor_command);
    motor_status = new ros::Publisher("roboy/middleware/MotorStatus",&status_msg);
    status_msg.angle_length = 1;
    status_msg.current_length = 1;
    status_msg.displacement_length = 1;
    status_msg.position_length = 1;
    status_msg.velocity_length = 1;
}
void M3::update(){
    static int counter = 0;
    int32_t val = a1335.readAngleRaw();
    if(counter++%2==0){
      if(angle>980 && val<50){
        rev_counter++;
      }
      if(angle<50 && val>980){
        rev_counter--;
      }
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
void M3::sendStatus(){
    status_msg.angle[0] = angle;
    status_msg.position[0] = angleAbsolute;
    status_msg.velocity[0] = angleAbsoluteVelocity;
    status_msg.displacement[0] = displacement;
    status_msg.pwm_ref[0] = pwmRef;
}
void M3::initWifi(){
    WiFi.begin(ssid, password);
    Serial.print("\nConnecting to "); Serial.println(ssid);
    uint8_t i = 0;
    while (WiFi.status() != WL_CONNECTED && i++ < 20) delay(500);
    if(i == 21){
      Serial.print("Could not connect to"); Serial.println(ssid);
      while(1) delay(500);
    }
    Serial.print("Ready! Use ");
    Serial.print(WiFi.localIP());
    Serial.println(" to access client");
    status_msg.id = WiFi.localIP();
    String str("roboy/middleware/");
    str.concat(WiFi.localIP().toString());
    str.concat("/ControlMode");
    control_mode = new ros::ServiceServer<roboy_middleware_msgs::ControlModeRequest,
                   roboy_middleware_msgs::ControlModeResponse>(str.c_str(), &ControlMode);
    nh.advertiseService<roboy_middleware_msgs::ControlModeRequest,
                   roboy_middleware_msgs::ControlModeResponse>(*control_mode);
}
void  M3::MotorCommand(const roboy_middleware_msgs::MotorCommand& msg) {
      if(msg.id==id){
          if(msg.set_points_length>0){
            setPoint = msg.set_points[0];
          }
      }
    }
void M3::ControlMode(const roboy_middleware_msgs::ControlModeRequest& req,
                    roboy_middleware_msgs::ControlModeResponse& res) {
    cm = req.control_mode;
    setPoint = req.set_point;
}
