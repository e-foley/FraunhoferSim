#include "stepper_controller.h"

StepperController::StepperController(BipolarStepper* const stepper, const int steps_per_rotation)
    : stepper_(stepper), steps_per_rotation_(steps_per_rotation), position_(0), target_angle_(0.0f),
      target_steps_(0), behavior_(Behavior::STOPPED) {}

void StepperController::forward() {
  behavior_ = Behavior::FORWARD;
}

void StepperController::backward() {
  behavior_ = Behavior::BACKWARD;
}

void StepperController::stop() {
  behavior_ = Behavior::STOPPED;
}

float StepperController::rotateTo(const float angle) {
  target_angle_ = angle;
  target_steps_ = degreesToSteps(target_angle_);
  behavior_ = Behavior::TARGETING;
  return stepsToDegrees(target_steps_);
}

float StepperController::rotateBy(const float relative_angle) {
  return rotateTo(target_angle_ + relative_angle);
}

float StepperController::getPosition() const {
  return stepsToDegrees(position_);
}

void StepperController::setZero(const float relative_angle) {
  position_ = degreesToSteps(-relative_angle);
}

// Note: Instead of a switch tree, we could just set a function pointer (to a private helper
// function) whenever we alter behavior_.  A function-pointer approach might be overkill though...
void StepperController::update() {
  switch (behavior_) {
    default:
    case Behavior::STOPPED:
    case Behavior::REACHED_TARGET:
      break;
    case Behavior::FORWARD:
      stepper_->stepForward();
      break;
    case Behavior::BACKWARD:
      stepper_->stepBackward();
      break;
    case Behavior::TARGETING:
      if (position_ < target_steps_) {
        stepper_->stepForward();
      } else if (position_ > target_steps_) {
        stepper_->stepBackward();
      } else /*position_ == target_steps_*/ {
        behavior_ = Behavior::REACHED_TARGET;
      }
      break;
  }
}

int32_t StepperController::degreesToSteps(const float degrees) const {
  return static_cast<int32_t>(round(degrees / 360.0f * steps_per_rotation_));
}

float StepperController::stepsToDegrees(const int32_t steps) const {
  return 360.0f * steps / steps_per_rotation_;
}
