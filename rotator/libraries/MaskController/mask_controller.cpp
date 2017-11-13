#include "mask_controller.h"

MaskController::MaskController(StepperController* stepper, float gear_ratio) : stepper_(stepper),
    direction_(Direction::BIDIRECTIONAL), angle_(0.0f), gear_ratio_(gear_ratio) {}

void MaskController::initialize() {
  return;
}

void MaskController::step() {
  return;
}

void MaskController::setPreferredDirection(MaskController::Direction direction) {
  direction_ = direction;
}

MaskController::Direction MaskController::getPreferredDirection() const {
  return direction_;
}
