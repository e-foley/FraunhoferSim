#include "Arduino.h"
#include "bipolar_stepper.h"
#include "mask_controller.h"
#include "stepper_controller.h"
#include "timer_one.h"

const float GEAR_RATIO = 72.0/17.0;
const int16_t MOTOR_STEPS = 200u;
const int BRKA_PIN = 9;
const int DIRA_PIN = 12;
const int PWMA_PIN = 3;
const int BRKB_PIN = 8;
const int DIRB_PIN = 13;
const int PWMB_PIN = 11;
uint32_t STEP_PERIOD_US = 8000u;  // [us]


BipolarStepper stepper(BRKA_PIN, DIRA_PIN, PWMA_PIN, BRKB_PIN, DIRB_PIN, PWMB_PIN);
StepperController motor_controller(&stepper, MOTOR_STEPS);
MaskController mask_controller(&motor_controller, GEAR_RATIO);
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
    const char command = Serial.peek();
    switch (command) {
      case 'f':
        // Go forward.
        Serial.read();
        mask_controller.counterclockwise();
        break;
      case 'b':
        // Go backward.
        Serial.read();
        mask_controller.clockwise();
        break;
      case 's':
        // Stop.
        Serial.read();
        mask_controller.stop();
        break;
      default: {
        float actual = motor_controller.rotateTo(Serial.parseFloat() / GEAR_RATIO);
        Serial.print("Target set to ");
        Serial.println(actual * GEAR_RATIO);
        break;
      }
    }
  }
}

void update() {
  motor_controller.update();
}
