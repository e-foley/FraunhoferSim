#include "mask_controller.h"

MaskController::MaskController(StepperController* const stepper_controller, const float gear_ratio)
    : stepper_controller_(stepper_controller), gear_ratio_(gear_ratio), target_(0.0f) {}

// void MaskController::initialize() {
//   return;
// }

void MaskController::counterclockwise() {
  if (stepper_controller_ == nullptr) {
    return;
  } else if (gear_ratio_ > 0.0f) {
    stepper_controller_->forward();
  } else {
    stepper_controller_->backward();
  }
}

void MaskController::clockwise() {
  if (stepper_controller_ == nullptr) {
    return;
  } else if (gear_ratio_ > 0.0f) {
    stepper_controller_->backward();
  } else {
    stepper_controller_->forward();
  }
}

void MaskController::stop() {
  if (stepper_controller_ == nullptr) {
    return;
  } else {
    stepper_controller_->stop();
  }
}

float MaskController::rotateTo(const float angle, const Direction direction) {
  if (stepper_controller_ == nullptr) {
    return 0.0f;
  }

  target_ = angle;
  const float wrapped_target = wrapAngle(target_);
  //const float motor_angle = stepper_controller_->getPosition();


  switch (direction) {
    default:
    case Direction::NONE:
      break;
    case Direction::FORWARD:

      break;
    case Direction::BACKWARD:
      break;
    case Direction::AUTO:
      if (angle )
      break;
  }

  float motor_target

  return 0.0f;
}

float MaskController::rotateBy(const float relative_angle) {
  target_ += relative_angle;
  return motorToMaskAngle(stepper_controller_->rotateTo(maskToMotorAngle(target_)));
}

float MaskController::getPosition() const {
  return wrapAngle(motorToMaskAngle(stepper_controller_->getPosition()));
}

float MaskController::getTarget() const {
  return wrapAngle(target_);
}

void MaskController::setZero(const float relative_angle) {
  return;
}

// Returns any absolute angle on [0, 360)
float MaskController::wrapAngle(const float nominal) {
  return nominal - 360.0f * floor(nominal / 360.0f);
}

float MaskController::unwrapAngle(const float angle) const {
  return 0.0f;
}

float MaskController::wrappedDifference(const float a, const float b) {

}

float MaskController::maskToMotorAngle(const float mask_angle) const {
  return mask_angle * gear_ratio_;
}

float MaskController::motorToMaskAngle(const float motor_angle) const {
  return motor_angle / gear_ratio_;
}
