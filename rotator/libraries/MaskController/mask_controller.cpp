#include "mask_controller.h"

MaskController::MaskController(volatile StepperController* const stepper_controller,
    const float gear_ratio) : stepper_controller_(stepper_controller), gear_ratio_(gear_ratio),
    target_(0.0f) {}

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

float MaskController::rotateTo(const float angle, const Direction direction,
    const bool wrap_result) {
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

  float nominal = 0.0f;
  if (gear_ratio_ > 0.0f) {
    nominal = motorToMaskAngle(stepper_controller_->rotateTo(motor_angle + maskToMotorAngle(delta_to_use)));
  } else {
    nominal = motorToMaskAngle(stepper_controller_->rotateTo(motor_angle + maskToMotorAngle(-delta_to_use)));
  }

  return wrap_result ? wrapAngle(nominal) : nominal;
}

float MaskController::rotateBy(const float relative_angle, const bool wrap_result) {
  target_ = motorToMaskAngle(stepper_controller_->rotateBy(maskToMotorAngle(relative_angle)));
  return wrap_result ? wrapAngle(target_) : target_;
}

float MaskController::getPosition(const bool wrap_result) const {
  const float nominal = motorToMaskAngle(stepper_controller_->getPosition());
  return wrap_result ? wrapAngle(nominal) : nominal;
}

float MaskController::getTarget(const bool wrap_result) const {
  return wrap_result ? wrapAngle(target_) : target_;
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
