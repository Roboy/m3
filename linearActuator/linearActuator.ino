// defines pins numbers
const int stepPin = 3; 
const int dirPin = 4; 
const int upPin = 5; 
const int downPin = 6; 
const int downEndSwitch = 7; 
const int upEndSwitch = 8; 
 
void setup() {
  // Sets the two pins as Outputs
  pinMode(stepPin,OUTPUT); 
  pinMode(dirPin,OUTPUT);
  pinMode(upPin,INPUT_PULLUP); 
  pinMode(downPin,INPUT_PULLUP);
  pinMode(upEndSwitch,INPUT_PULLUP); 
  pinMode(downEndSwitch,INPUT_PULLUP);
  Serial.begin(115200);
}
void loop() {
  if(!digitalRead(downPin)){//down
    if(digitalRead(downEndSwitch)){
      digitalWrite(dirPin,1); // Enables the motor to move in a particular direction
      digitalWrite(stepPin,HIGH); 
      delayMicroseconds(500); 
      digitalWrite(stepPin,LOW); 
      delayMicroseconds(500); 
    }else{
      Serial.println("endswitch down triggered");
    }
  }
  if(!digitalRead(upPin)){//up
      if(digitalRead(upEndSwitch)){
        digitalWrite(dirPin,0); // Enables the motor to move in a particular direction
        digitalWrite(stepPin,HIGH); 
        delayMicroseconds(500); 
        digitalWrite(stepPin,LOW); 
        delayMicroseconds(500); 
      }else{
        Serial.println("endswitch up triggered");
      }
  }
}
