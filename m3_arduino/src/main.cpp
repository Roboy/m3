#include "m3.hpp"
#include <ESP8266WiFi.h>
M3 *m3;

// the setup routine runs once when you press reset:
void setup() {
  Serial.begin(115200);
  Serial.println("welcome stranger");
  WiFi.mode(WIFI_STA);
  WiFi.begin("roboy", "wiihackroboy");
  while (WiFi.status() != WL_CONNECTED){
      delay(1000);
      Serial.println(".");
  }
  m3 = new M3(0x0C,12,A0);
  m3->init();
  // m3->sendStatus();
}


int counter = 0;

void loop() {
  m3->update();
  m3->updateController();
//  m3.printStatus();
  m3->sendStatus();
  m3->nh.spinOnce();
  delay(5);
}
