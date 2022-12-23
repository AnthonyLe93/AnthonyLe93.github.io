
/*
 Stepper Motor Control - speed control

 This program drives a unipolar or bipolar stepper motor.
 The motor is attached to digital pins 8 - 11 of the Arduino.
 A potentiometer is connected to analog input 0.

 The motor will rotate in a clockwise direction. The higher the potentiometer value,
 the faster the motor speed. Because setSpeed() sets the delay between steps,
 you may notice the motor is less responsive to changes in the sensor value at
 low speeds.

 Created 30 Nov. 2009
 Modified 28 Oct 2010
 by Tom Igoe

 */

#include <Stepper.h>

const int stepsPerRevolution = 3200;  // 1.8 degree, 1/16 microstep = 3200 steps per revolution (change this to fit the number of steps per revolution)
                                     // each revolution is 2mm, so 1600 steps per 1mm. 

// initialize the stepper library on pins 8 through 11:
Stepper myStepper(stepsPerRevolution, 8, 9, 10, 11);

int reverseSwitch = 2;  // Push button for reverse
int forwardSwitch = 3; //push button to start
int backwardSwitch = 4; //push button to start
double stepCount = 0;  // number of steps the motor has taken
double reverseStepCount = 0; 
double distanceTravel = 0;
boolean setdir = LOW; // Set Direction
// variables will change:
int buttonState1 = 0;         // variable for reading the forward pushbutton status
int buttonState2 = 0;         // variable for reading the backward pushbutton status

// Interrupt Handler
 
void revmotor (){
 
  setdir = !setdir;
  
}
 

void setup() {
  
  // set the speed at 60 rpm:
  myStepper.setSpeed(60);
  // initialize the pushbutton pin as an input:
  pinMode(forwardSwitch, INPUT);
  pinMode(backwardSwitch, INPUT);
   // initialize the serial port:
  attachInterrupt(digitalPinToInterrupt(reverseSwitch), revmotor, FALLING);
  Serial.begin(9600);
  
}

void loop() {
  // read the state of the start pushbutton value:
  buttonState1 = digitalRead(forwardSwitch);
  buttonState2 = digitalRead(backwardSwitch);
  if(buttonState1 == LOW){
    myStepper.step(-1000);
  }
  if(buttonState2 == LOW){
    myStepper.step(1000);
  }
    // step one step  in one direction:
    if (setdir == LOW){
    Serial.println("clockwise");
    myStepper.step(stepsPerRevolution);
    stepCount++;
    reverseStepCount = stepCount; 
    Serial.print("steps:");
    Serial.println(stepCount);   
    delayMicroseconds(50);
    }
    else {
    Serial.println("Counterclockwise");
    distanceTravel = (stepCount * stepsPerRevolution) / 1600 ; // mm 
    Serial.print("Distance: ");
    Serial.println(distanceTravel);
      if (reverseStepCount == 0){
      stepCount = 0; // reset stepCount  
      delay(50); //delay 5 seconds
      } 
      else{
      for(int i = 1; i <= stepCount; i++){   
      myStepper.step(-stepsPerRevolution);
      reverseStepCount--;     
      delayMicroseconds(50);      
      }
      } 
        
    }
}
