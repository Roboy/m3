#include "m3.hpp"

M3 m3(0x0C,12,A0);

// the setup routine runs once when you press reset:
void setup() {
  Serial.begin(115200);
  Serial.println("welcome stranger");
  m3.initWifi();
}

int counter = 0;

void loop() {
  m3.update();
  m3.updateController();
//  m3.printStatus();
  if(counter++%10==0){
    m3.sendStatus();
  }
  m3.nh.spinOnce();
}
