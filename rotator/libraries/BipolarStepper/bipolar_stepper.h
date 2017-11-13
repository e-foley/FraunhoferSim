#ifndef BIPOLAR_STEPPER_H_
#define BIPOLAR_STEPPER_H_

#include <Arduino.h>

class BipolarStepper {
 public:
  BipolarStepper(uint16_t steps, int brka, int dira, int pwma, int brkb, int dirb, int pwmb);
  void initialize();
  void enable();
  void disable();
  bool isEnabled() const;
  void setTarget(int32_t target_setting);
  void setTargetDegrees(float target_setting);
  int32_t getTarget() const;
  float getTargetDegrees() const;
  int32_t getPosition() const;
  float getPositionDegrees() const;
  void setCurrentPosition(int32_t position_set);
  void setCurrentPositionDegrees(float position_set);
  void zero();
  int32_t degreesToTicks(float degrees) const;
  float ticksToDegrees(int32_t ticks) const;
  void stepForward();
  void stepBackward();
  void stepTowardTarget();
  int getState() const;

 private:
  static const int NUM_STATES = 4;

  void doState(int state);

  // Arduino pins corresponding to motor functions.
  const int brka_;
  const int dira_;
  const int pwma_;
  const int brkb_;
  const int dirb_;
  const int pwmb_;
  const uint16_t steps_;
  int32_t position_;
  int32_t target_;
  bool enabled_;
  int state_;
  bool initialized_;
};

#endif
