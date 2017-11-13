#include "stepper_controller.h"

StepperController::StepperController(BipolarStepper* stepper, int steps_per_rotation,
    TimerOne* timer, uint32_t step_period_us) : steps_per_rotation_(steps_per_rotation),
    timer_(timer), step_period_us_(step_period_us) {
  stepper_ = stepper;
}

void StepperController::initialize() {
  timer_->attachInterrupt(&StepperController::update, 1000u);
}

float StepperController::rotateTo(float angle, Direction direction) {



  return 0.0f;
}

void StepperController::update() {
  // stepper_->
}
