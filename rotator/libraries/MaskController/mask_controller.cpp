#include "mask_controller.h"

MaskController::MaskController(StepperController* const stepper_controller, const float gear_ratio)
    : stepper_controller_(stepper_controller), gear_ratio_(gear_ratio), target_(0.0f) {}

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
    return NAN;
  }

  // Stop and record because the motor angle would theoretically change as we progress through the
  // function if we didn't do this.
  stepper_controller_->stop();
  const float motor_angle = stepper_controller_->getPosition();
  const float forward_delta = wrapAngle(angle - motorToMaskAngle(motor_angle));
  const float reverse_delta = wrapAngle(motorToMaskAngle(motor_angle) - angle);
  target_ = angle;

  float delta_to_use = 0.0f;
  switch (direction) {
    default:
    case Direction::NONE:
      break;
    case Direction::COUNTERCLOCKWISE:
      delta_to_use = forward_delta;
      break;
    case Direction::CLOCKWISE:
      delta_to_use = -reverse_delta;
      break;
    case Direction::AUTO:
      delta_to_use = forward_delta < reverse_delta ? forward_delta : -reverse_delta;
      break;
  }

  if (gear_ratio_ > 0.0f) {
    return wrapAngle(motorToMaskAngle(stepper_controller_->rotateTo(motor_angle + maskToMotorAngle(delta_to_use))));
  } else {
    return wrapAngle(motorToMaskAngle(stepper_controller_->rotateTo(motor_angle + maskToMotorAngle(-delta_to_use))));
  }
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
  if (stepper_controller_ == nullptr) {
    return;
  }
  stepper_controller_->stop();
  stepper_controller_->setZero(maskToMotorAngle(relative_angle));
}

float MaskController::wrapAngle(const float nominal) {
  return nominal - 360.0f * floor(nominal / 360.0f);
}

float MaskController::maskToMotorAngle(const float mask_angle) const {
  return mask_angle * gear_ratio_;
}

float MaskController::motorToMaskAngle(const float motor_angle) const {
  return motor_angle / gear_ratio_;
}
