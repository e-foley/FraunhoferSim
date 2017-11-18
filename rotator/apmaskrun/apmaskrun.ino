#include "Arduino.h"
#include "bipolar_stepper.h"
#include "mask_controller.h"
#include "stepper_controller.h"
#include "timer_one.h"

const float GEAR_RATIO = 17.0/72.0;
const int16_t MOTOR_STEPS = 200u;
const int BRKA_PIN = 9;
const int DIRA_PIN = 12;
const int PWMA_PIN = 3;
const int BRKB_PIN = 8;
const int DIRB_PIN = 13;
const int PWMB_PIN = 11;
uint32_t STEP_PERIOD_US = 5000u;  // [us] (3500, 4000, 4444, 5000 work well)

BipolarStepper stepper(BRKA_PIN, DIRA_PIN, PWMA_PIN, BRKB_PIN, DIRB_PIN, PWMB_PIN);
StepperController controller(&stepper, MOTOR_STEPS);
TimerOne timer;

float target = 0.0f;
bool dir = true;

void setup() {
  Serial.begin(19200);
  Serial.setTimeout(10);
  stepper.initialize();
  stepper.enable();
  timer.initialize();
  timer.attachInterrupt(update, STEP_PERIOD_US);
}

void loop() {
  if (Serial.available()) {
    float actual = controller.rotateTo(Serial.parseFloat() / GEAR_RATIO);
    Serial.print("Target set to ");
    Serial.println(actual * GEAR_RATIO);
  }
}

void update() {
  controller.update();
}
