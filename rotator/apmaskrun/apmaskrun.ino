#include <BipolarStepper.h>
#include <Arduino.h>
#include <TimerOne.h>

const float GEAR_RATIO = 24.0/72.0;
const uint16_t MOTOR_STEPS = 200u;
const int BRKA_PIN = 9;
const int DIRA_PIN = 12;
const int PWMA_PIN = 3;
const int BRKB_PIN = 8;
const int DIRB_PIN = 13;
const int PWMB_PIN = 11;
uint32_t STEP_PERIOD_US = 5000;  // [us] (3500, 4000, 4444, 5000 work well)

BipolarStepper stepper(MOTOR_STEPS, BRKA_PIN, DIRA_PIN, PWMA_PIN, BRKB_PIN, DIRB_PIN, PWMB_PIN);
TimerOne timer;

float target;
bool dir;

void setup() {
  Serial.begin(19200);
  Serial.setTimeout(10);
  stepper.initialize();
  stepper.enable();
  //stepper.forceDirection(BipolarStepper::BIDIRECTIONAL);
  timer.initialize();
  timer.attachInterrupt(update, STEP_PERIOD_US);
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
