#include <BipolarStepper.h>
#include <Arduino.h>
#include <TimerOne.h>

BipolarStepper stepper(200, 9, 12, 3, 8, 13, 11);
TimerOne timer;

float target;
bool dir;

const float GEAR_RATIO = 24.0/72.0;

void setup() {
  Serial.begin(19200);
  Serial.setTimeout(10);
  stepper.initialize();
  stepper.enable();
  //stepper.forceDirection(BipolarStepper::BIDIRECTIONAL);
  timer.initialize();
  timer.attachInterrupt(update, 5000); // 3500, 4000, 4444, 5000 work well
  target = 0.0f;
  dir = true;
}

void loop() {
//  if (dir && stepper.getPositionDegrees() > target) {
//    dir = false;
//    stepper.setTargetDegrees(10.0f);
//    stepper.forceDirection(
//  } else if (!dir && stepper.getPositionDegrees() < target) {
//    dir = true;
//    stepper.setTargetDegrees(350.0f);
//  }
  if (Serial.available()) {
    stepper.setTargetDegrees(Serial.parseFloat() / GEAR_RATIO);
    Serial.print("Target set to ");
    Serial.println(stepper.getTargetDegrees() * GEAR_RATIO);
  }
}

void update() {
  stepper.stepTowardTarget();
}
