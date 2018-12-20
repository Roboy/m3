/*
  Blink
  Turns on an LED on for one second, then off for one second, repeatedly.
 
  This example code is in the public domain.
 */

#include <Wire.h>
#include <A1335.h>
#include <Servo.h>
#include <ESP8266WiFi.h>
#include <WiFiUdp.h>
#include "wirelessLove.hpp"
#define SPINDLE_RADIUS 0.0057
WiFiUDP Udp;
unsigned int localUdpPort = 8000;
IPAddress remoteIP(255,255,255,255);
int remote_port = 8002;
char incomingPacket[255];
const char* ssid = "roboy";
const char* passwd = "wiihackroboy";

class M3{
  public:
  M3(uint8_t deviceId, int servoPin, int analogPin):servoPin(servoPin),analogPin(analogPin){
    Wire.begin();
    a1335.start(deviceId);
    servo.attach(servoPin);
  }
  void update(){
    static int counter = 0;
    float val = a1335.readAngle();
    if(counter++%2==0){
      if(angle>300.0 && val<60.0){
        rev_counter++;
      }
      if(angle<60.0 && val>300.0){
        rev_counter--;
      }
    }
    angle = val;
    angleAbsolute = rev_counter*360.0 + angle;
    displacement = analogRead(analogPin);
    force = (displacement/1024.0)*20.0*springConstant;
    position = (angleAbsolute * 6.28318530718 * SPINDLE_RADIUS) - ((displacement/1024.0)*20.0);
  }
  void controlPosition(){
    static float angle_prev = 0, error_prev = 0;
    float error = (target_pos-angleAbsolute);
    float control = Kp*error + Kd*(error-error_prev);
    if(control>20){
      control = 20;
    }else if(control < -20){
      control = -20;
    }
    pwmRef = 90 + control;
    servo.write(pwmRef);
  }
  void controlForce(){
    static float force_prev = 0, error_prev = 0;
    float error = (target_force-force);
    float control = Kp*error + Kd*(error-error_prev);
    if(control>20){
      control = 20;
    }else if(control < -20){
      control = -20;
    }
    pwmRef = 90 + control;
    servo.write(pwmRef);
  }
  void printStatus(){
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
  void broadCastStatus(){
    int32_t val0 = pack754_32(position);
    int32_t val1 = pack754_32(displacement);
    int32_t val2 = pack754_32(force);
    memcpy(&buf[0],&val0,4);
    memcpy(&buf[4],&val1,4);
    memcpy(&buf[8],&val2,4);
    if(0 == Udp.beginPacket(remoteIP, remote_port))
    {
        Serial.println("Can not connect to the supplied IP or PORT");
    }

    if(12 != Udp.write(buf,12)){
        Serial.println("Size of the UDP Package to big! Truncated overlapping data");
    }
    Udp.endPacket();
  }
  void initWifi(){
    WiFi.mode(WIFI_STA);
    WiFi.begin(ssid, passwd);
    while (WiFi.waitForConnectResult() != WL_CONNECTED) {
        Serial.println("WiFi Failed");
        delay(1000);
    }
    Udp.begin(localUdpPort);
  }
  public:
    int pwmRef = 90;
    float angle = 0;
    float angleAbsolute = 0;
    float position = 0;
    int rev_counter = 0;
    float displacement = 0;
    float force = 0, target_force = 0, target_pos = 0;
    float Kp = 0.1, Kd = 0.05;
    Servo servo;
    A1335 a1335;
    int analogPin, servoPin;
    const float springConstant = 5.241;
    uint8_t buf[12];
    int control_mode = 0;
//    AsyncUDP udp;
};

M3 m3(0x0C,12,A0);

// the setup routine runs once when you press reset:
void setup() {        
  Serial.begin(115200);      
  Serial.println("welcome stranger");
  m3.initWifi();  
//  if(m3.udp.connect(IPAddress(192,168,0,227), 8000)) {
//      Serial.println("UDP connected");
//      m3.udp.onPacket([](AsyncUDPPacket packet) {
//          Serial.print("UDP Packet Type: ");
//          Serial.print(packet.isBroadcast()?"Broadcast":packet.isMulticast()?"Multicast":"Unicast");
//          Serial.print(", From: ");
//          Serial.print(packet.remoteIP());
//          Serial.print(":");
//          Serial.print(packet.remotePort());
//          Serial.print(", To: ");
//          Serial.print(packet.localIP());
//          Serial.print(":");
//          Serial.print(packet.localPort());
//          Serial.print(", Length: ");
//          Serial.print(packet.length());
//          Serial.print(", Data: ");
//          Serial.write(packet.data(), packet.length());
//          Serial.println();
//      });
//  }
//  m3.findZeroVelocity();
  
}

int counter = 0;

// the loop routine runs over and over again forever:
void loop() {
  int packetSize = Udp.parsePacket();
  if (packetSize == 5)
  {
//    Serial.printf("Received %d bytes from %s, port %d\n", packetSize, Udp.remoteIP().toString().c_str(), Udp.remotePort());
    int32_t data;
    int len = Udp.read(incomingPacket, 255);
    memcpy(&data,incomingPacket,4);
    m3.control_mode = incomingPacket[4];
    switch(m3.control_mode){
      case 0:
        m3.target_pos = unpack754_32(data);
        Serial.printf("target_pos: %f, control_mode %d\n", m3.target_pos, m3.control_mode);
        break;
      case 1:
        m3.target_force = unpack754_32(data);
        Serial.printf("target_force: %f, control_mode %d\n", m3.target_force, m3.control_mode);
        break;
    }
  }
  m3.update();
  switch(m3.control_mode){
    case 0:
      m3.controlPosition();
      break;
    case 1:
      m3.controlForce();
      break;
  }
//  m3.printStatus();
  if(counter++%10==0){
    m3.broadCastStatus();
  }
  delay(5);
}
