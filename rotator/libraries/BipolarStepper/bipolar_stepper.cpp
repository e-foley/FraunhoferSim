#include "Arduino.h"
#include "Math.h"
#include "bipolar_stepper.h"

BipolarStepper::BipolarStepper(int brka, int dira, int pwma, int brkb, int dirb, int pwmb)
    : brka_(brka), dira_(dira), pwma_(pwma), brkb_(brkb), dirb_(dirb), pwmb_(pwmb), state_(0),
    initialized_(false), enabled_(false) {}

BipolarStepper::~BipolarStepper() {
  // Put our outputs in what should be a safe state before destroying the object that controls them.
  digitalWrite(brka_, LOW);
  digitalWrite(dira_, LOW);
  digitalWrite(pwma_, LOW);
  digitalWrite(brkb_, LOW);
  digitalWrite(dirb_, LOW);
  digitalWrite(pwmb_, LOW);
}

void BipolarStepper::initialize() {
  pinMode(brka_, OUTPUT);
  pinMode(dira_, OUTPUT);
  pinMode(pwma_, OUTPUT);
  pinMode(brkb_, OUTPUT);
  pinMode(dirb_, OUTPUT);
  pinMode(pwmb_, OUTPUT);
  doState(state_);
  initialized_ = true;
}

bool BipolarStepper::isInitialized() const {
  return initialized_;
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

void BipolarStepper::stepForward() {
  if (!initialized_ || !enabled_) {
    return;
  }

  state_ = (state_ + 1) % NUM_STATES;
  doState(state_);
}

void BipolarStepper::stepBackward() {
  if (!initialized_ || !enabled_) {
    return;
  }

  state_ = (state_ + NUM_STATES - 1) % NUM_STATES;
  doState(state_);
}

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
    default:
      // Can't get here.
      break;
  }
}
