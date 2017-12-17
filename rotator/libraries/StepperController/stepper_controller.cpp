#include "stepper_controller.h"

StepperController::StepperController(BipolarStepper* const stepper, const int steps_per_rotation)
    : stepper_(stepper), steps_per_rotation_(steps_per_rotation), position_(0), target_angle_(0.0f),
      target_steps_(0), behavior_(Behavior::STOPPED) {}

void StepperController::forward() volatile {
  behavior_ = Behavior::FORWARD;
}

void StepperController::reverse() volatile {
  behavior_ = Behavior::REVERSE;
}

void StepperController::stop() volatile {
  behavior_ = Behavior::STOPPED;
}

float StepperController::rotateTo(const float angle) volatile {
  behavior_ = Behavior::STOPPED;  // Very brief pause to avoid potential momentary direction change.
  target_angle_ = angle;
  target_steps_ = degreesToSteps(target_angle_);
  behavior_ = Behavior::TARGETING;
  return stepsToDegrees(target_steps_);
}

float StepperController::rotateBy(const float relative_angle) volatile {
  behavior_ = Behavior::STOPPED;  // Very brief pause to avoid position_ changes.
  target_angle_ = stepsToDegrees(position_) + relative_angle;
  target_steps_ = degreesToSteps(target_angle_);
  behavior_ = Behavior::TARGETING;
  return target_angle_;
}

float StepperController::getPosition() const volatile {
  // TODO: Disable interrupts here.
  return stepsToDegrees(position_);
}

float StepperController::getTarget() const volatile {
  return target_angle_;
}

void StepperController::setZero(const float relative_angle) volatile {
  position_ = degreesToSteps(-relative_angle);
}

// Note: Instead of a switch tree, we could just set a function pointer (to a private helper
// function) whenever we alter behavior_.  A function-pointer approach might be overkill though...
void StepperController::update() volatile {
  if (stepper_ == nullptr) {
    return;
  }

  switch (behavior_) {
    default:
    case Behavior::STOPPED:
    case Behavior::REACHED_TARGET:
      break;
    case Behavior::FORWARD:
      stepper_->stepForward();
      position_++;
      break;
    case Behavior::REVERSE:
      stepper_->stepBackward();
      position_--;
      break;
    case Behavior::TARGETING:
      if (position_ < target_steps_) {
        stepper_->stepForward();
        position_++;
      } else if (position_ > target_steps_) {
        stepper_->stepBackward();
        position_--;
      } else /*position_ == target_steps_*/ {
        behavior_ = Behavior::REACHED_TARGET;
      }
      break;
  }
}

int32_t StepperController::degreesToSteps(const float degrees) const volatile {
  return static_cast<int32_t>(round(degrees / 360.0f * steps_per_rotation_));
}

float StepperController::stepsToDegrees(const int32_t steps) const volatile {
  return 360.0f * steps / steps_per_rotation_;
}
