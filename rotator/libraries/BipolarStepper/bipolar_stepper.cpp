#include "Arduino.h"
#include "Math.h"
#include "bipolar_stepper.h"

BipolarStepper::BipolarStepper(uint16_t steps, int brka, int dira, int pwma, int brkb, int dirb,
    int pwmb) : brka_(brka), dira_(dira), pwma_(pwma), brkb_(brkb), dirb_(dirb), pwmb_(pwmb),
    steps_(steps), position_(0), target_(0), enabled_(false), state_(0), initialized_(false) {}

void BipolarStepper::initialize() {
  pinMode(brka_, OUTPUT);
  pinMode(dira_, OUTPUT);
  pinMode(pwma_, OUTPUT);
  pinMode(brkb_, OUTPUT);
  pinMode(dirb_, OUTPUT);
  pinMode(pwmb_, OUTPUT);
  doState(state_);
  delay(200);
  zero();
  initialized_ = true;
}

void BipolarStepper::enable() {
  enabled_ = true;
}

void BipolarStepper::disable() {
  enabled_ = false;
}

bool BipolarStepper::isEnabled() const {
  return enabled_;
}

// void BipolarStepper::setTarget(int32_t target_setting) {
//   target_ = target_setting;
// }
//
// int32_t BipolarStepper::getTarget() const {
//   return target_;
// }

// float BipolarStepper::getTargetDegrees() const {
//   return ticksToDegrees(target_);
// }
//
// void BipolarStepper::setTargetDegrees(float target_setting) {
//   target_ = degreesToTicks(target_setting);
// }

int32_t BipolarStepper::getPosition() const {
  return position_;
}

// float BipolarStepper::getPositionDegrees() const {
//   return ticksToDegrees(position_);
// }

void BipolarStepper::setCurrentPosition(int32_t position_setting) {
  position_ = position_setting;
}

// void BipolarStepper::setCurrentPositionDegrees(float position_setting) {
//   position_ = degreesToTicks(position_setting);
// }

void BipolarStepper::zero() {
  position_ = 0;
}

// int32_t BipolarStepper::degreesToTicks(float degrees) const {
//   return static_cast<int32_t>(round(degrees / 360.0f * steps_));
// }
//
// float BipolarStepper::ticksToDegrees(int32_t ticks) const {
//   return 360.0f * ticks / steps_;
// }

void BipolarStepper::stepForward() {
  if (!initialized_ || !enabled_) {
    return;
  }

  state_ = (state_ + 1) % NUM_STATES;
  doState(state_);
  position_++;
}

void BipolarStepper::stepBackward() {
  if (!initialized_ || !enabled_) {
    return;
  }

  state_ = (state_ + NUM_STATES - 1) % NUM_STATES;
  doState(state_);
  position_--;
}

// void BipolarStepper::stepTowardTarget() {
//   if (!initialized_ || !enabled_ || position_ == target_) {
//     return;
//   }
//
//   if (position_ > target_) {
//     stepBackward();
//   } else if (position_ < target_) {
//     stepForward();
//   }
// }

void BipolarStepper::doState(int state) {
  state %= 4;
  switch (state) {
    case 0:
      digitalWrite(brka_, LOW);
      digitalWrite(brkb_, HIGH);
      digitalWrite(dira_, HIGH);
      analogWrite(pwma_, 255);
      break;
    case 1:
      digitalWrite(brka_, HIGH);
      digitalWrite(brkb_, LOW);
      digitalWrite(dirb_, LOW);
      analogWrite(pwmb_, 255);
      break;
    case 2:
      digitalWrite(brka_, LOW);
      digitalWrite(brkb_, HIGH);
      digitalWrite(dira_, LOW);
      analogWrite(pwma_, 255);
      break;
    case 3:
      digitalWrite(brka_, HIGH);
      digitalWrite(brkb_, LOW);
      digitalWrite(dirb_, HIGH);
      analogWrite(pwmb_, 255);
      break;
  }
}

int BipolarStepper::getState() const {
  return state_;
}
