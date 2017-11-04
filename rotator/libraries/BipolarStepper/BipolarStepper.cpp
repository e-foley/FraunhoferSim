#include <BipolarStepper.h>
#include <Math.h>
#include <Arduino.h>

BipolarStepper::BipolarStepper(uint16_t steps_set, int brka_set, int dira_set, int pwma_set,
    int brkb_set, int dirb_set, int pwmb_set) : brka(brka_set), dira(dira_set), pwma(pwma_set),
    brkb(brkb_set), dirb(dirb_set), pwmb(pwmb_set), steps(steps_set), position(0), target(0),
    enabled(false), state(0), initialized(false) {
  //direction = BIDIRECTIONAL;
}

void BipolarStepper::initialize() {
  pinMode(brka, OUTPUT);
  pinMode(dira, OUTPUT);
  pinMode(pwma, OUTPUT);
  pinMode(brkb, OUTPUT);
  pinMode(dirb, OUTPUT);
  pinMode(pwmb, OUTPUT);
  doState(state);
  delay(200);
  zero();
  initialized = true;
}

void BipolarStepper::enable() {
  enabled = true;
}

void BipolarStepper::disable() {
  enabled = false;
}

bool BipolarStepper::isEnabled() const {
  return enabled;
}

// void BipolarStepper::forceDirection(int direction_forcing) {
  // direction = direction_forcing;
// }

void BipolarStepper::setTarget(int32_t target_setting) {
  target = target_setting;
}

int32_t BipolarStepper::getTarget() const {
  return target;
}

float BipolarStepper::getTargetDegrees() const {
  return ticksToDegrees(target);
}

void BipolarStepper::setTargetDegrees(float target_setting) {
  target = degreesToTicks(target_setting);
}

int32_t BipolarStepper::getPosition() const {
  return position;
}

float BipolarStepper::getPositionDegrees() const {
  return ticksToDegrees(position);
}

void BipolarStepper::setCurrentPosition(int32_t position_setting) {
  position = position_setting;
}

void BipolarStepper::setCurrentPositionDegrees(float position_setting) {
  position = degreesToTicks(position_setting);
}

void BipolarStepper::zero() {
  position = 0;
}

// uint16_t BipolarStepper::degreesToTicks(float degrees)
// {
  // if (degrees >= 0.0f) {
    // return (uint16_t)(round(fmod(degrees, 360.0f) / 360.0f * steps));
  // } else {
    // return (uint16_t)(round(fmod(360.0f - fmod(-degrees, 360.0f), 360.0f) / 360.0f * steps)); // Outer mod function is to ensure inputs like -360.0f return 0 instead of steps
  // }
// }

int32_t BipolarStepper::degreesToTicks(float degrees) const {
  return (int32_t)(round(degrees / 360.0f * steps));
}

float BipolarStepper::ticksToDegrees(int32_t ticks) const {
  return 360.0f * ticks / steps;
}

void BipolarStepper::stepForward() {
  if (!initialized || !enabled) {
    return;
  }

  state = (state + 1) % NUM_STATES;
  doState(state);
  //position = (position + 1) % steps;
  position++;
}

void BipolarStepper::stepBackward() {
  if (!initialized || !enabled) {
    return;
  }

  state = (state + NUM_STATES - 1) % NUM_STATES;
  doState(state);
  //position = (position + steps - 1) % steps;
  position--;
}

// void BipolarStepper::stepTowardTarget() {
  // if (!enabled || position == target) {
    // return;
  // }

  // switch (direction) {
    // case FORWARD:
      // stepForward();
    // break;
    // case BACKWARD:
      // stepBackward();
    // break;
    // case BIDIRECTIONAL:
      // if ((position > target && position - target > steps / 2) || (position < target && target - position <= steps / 2)) {
        // stepForward();
      // } else {
        // stepBackward();
      // }
    // break;
    // default:
      // return;
    // break;
  // }
// }

void BipolarStepper::stepTowardTarget() {
  if (!initialized || !enabled || position == target) {
    return;
  }

  if (position > target) {
    stepBackward();
  } else if (position < target) {
    stepForward();
  }
}

// void BipolarStepper::step() {
  // if (!enabled) {
    // return;
  // }

  // switch (direction) {
    // case FORWARD:
      // stepForward();
    // break;
    // case BACKWARD:
      // stepBackward();
    // break;
    // default:
      // stepForward();
    // break;
  // }
// }

void BipolarStepper::doState(int state) {
  state = state % 4;
  switch (state) {
    case 0:
      digitalWrite(brka, LOW);
      digitalWrite(brkb, HIGH);
      digitalWrite(dira, HIGH);
      analogWrite(pwma, 255);
      break;
    case 1:
      digitalWrite(brka, HIGH);
      digitalWrite(brkb, LOW);
      digitalWrite(dirb, LOW);
      analogWrite(pwmb, 255);
      break;
    case 2:
      digitalWrite(brka, LOW);
      digitalWrite(brkb, HIGH);
      digitalWrite(dira, LOW);
      analogWrite(pwma, 255);
      break;
    case 3:
      digitalWrite(brka, HIGH);
      digitalWrite(brkb, LOW);
      digitalWrite(dirb, HIGH);
      analogWrite(pwmb, 255);
      break;
  }

  // switch (state) {
    // case 0:
      // digitalWrite(pin_1, HIGH);
      // digitalWrite(pin_2, LOW);
      // digitalWrite(pin_3, HIGH);
      // digitalWrite(pin_4, LOW);
    // break;
    // case 1:
      // digitalWrite(pin_1, LOW);
      // digitalWrite(pin_2, LOW);
      // digitalWrite(pin_3, HIGH);
      // digitalWrite(pin_4, LOW);
    // break;
    // case 2:
      // digitalWrite(pin_1, LOW);
      // digitalWrite(pin_2, HIGH);
      // digitalWrite(pin_3, HIGH);
      // digitalWrite(pin_4, LOW);
    // break;
    // case 3:
      // digitalWrite(pin_1, LOW);
      // digitalWrite(pin_2, HIGH);
      // digitalWrite(pin_3, LOW);
      // digitalWrite(pin_4, LOW);
    // break;
    // case 4:
      // digitalWrite(pin_1, LOW);
      // digitalWrite(pin_2, HIGH);
      // digitalWrite(pin_3, LOW);
      // digitalWrite(pin_4, HIGH);
    // break;
    // case 5:
      // digitalWrite(pin_1, LOW);
      // digitalWrite(pin_2, LOW);
      // digitalWrite(pin_3, LOW);
      // digitalWrite(pin_4, HIGH);
    // break;
    // case 6:
      // digitalWrite(pin_1, HIGH);
      // digitalWrite(pin_2, LOW);
      // digitalWrite(pin_3, LOW);
      // digitalWrite(pin_4, HIGH);
    // break;
    // case 7:
      // digitalWrite(pin_1, HIGH);
      // digitalWrite(pin_2, LOW);
      // digitalWrite(pin_3, LOW);
      // digitalWrite(pin_4, LOW);
    // break;
    // default:
      // digitalWrite(pin_1, HIGH);
      // digitalWrite(pin_2, HIGH);
      // digitalWrite(pin_3, HIGH);
      // digitalWrite(pin_4, HIGH);
    // break;
  // }
}

int BipolarStepper::getState() const {
  return state;
}
