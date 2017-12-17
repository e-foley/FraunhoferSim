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
const MaskController::Direction PREFERRED_DIRECTION = MaskController::Direction::AUTO;

BipolarStepper stepper(BRKA_PIN, DIRA_PIN, PWMA_PIN, BRKB_PIN, DIRB_PIN, PWMB_PIN);
volatile StepperController motor_controller(&stepper, MOTOR_STEPS);
MaskController mask_controller(&motor_controller, GEAR_RATIO);
TimerOne timer;

enum class Mode {
  NONE,
  ABSOLUTE,
  RELATIVE
} mode = Mode::ABSOLUTE;

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
        Serial.println("Moving mask forward.");
        mask_controller.forward();
        break;
      case 'b':
        // Go backward.
        Serial.read();
        Serial.println("Moving mask backward.");
        mask_controller.reverse();
        break;
      case 's':
        // Stop.
        Serial.read();
        Serial.println("Mask stopped.");
        mask_controller.stop();
        break;
      case 'p':
        // Retrieve mask position.
        Serial.read();
        Serial.print("Current mask position: ");
        Serial.print(mask_controller.getPosition(true));
        Serial.print(" deg (");
        Serial.print(mask_controller.getPosition(false));
        Serial.println(" deg)");
        break;
      case 't':
        // Retrieve mask target position.
        Serial.read();
        Serial.print("Mask target position: ");
        Serial.print(mask_controller.getTarget(true));
        Serial.print(" deg (");
        Serial.print(mask_controller.getTarget(false));
        Serial.println(" deg)");
        break;
      case 'z':
        // Zero current mask position.
        Serial.read();
        mask_controller.setZero();
        Serial.println("Mask position zeroed.");
        break;
      case 'r':
        Serial.read();
        mode = Mode::RELATIVE;
        Serial.println("Mode set to relative.");
        break;
      case 'a':
        Serial.read();
        mode = Mode::ABSOLUTE;
        Serial.println("Mode set to absolute.");
        break;
      default: {
        float actual = 0.0f;
        if (mode == Mode::ABSOLUTE) {
          actual = mask_controller.rotateTo(Serial.parseFloat(), PREFERRED_DIRECTION);
          Serial.print("Target set to ");
          Serial.print(actual);
          Serial.println(" degrees.");
        } else if (mode == Mode::RELATIVE) {
          const float relative_angle = Serial.parseFloat();
          actual = mask_controller.rotateBy(relative_angle);
          Serial.print("Rotating mask by ");
          Serial.print(relative_angle);
          Serial.print(" degrees to new target of ");
          Serial.print(actual);
          Serial.println(" degrees.");
        }
        break;
      }
    }
  }
}

void update() {
  motor_controller.update();
}
