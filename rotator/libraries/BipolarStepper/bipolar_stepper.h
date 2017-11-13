#ifndef BIPOLAR_STEPPER_H_
#define BIPOLAR_STEPPER_H_

#include <Arduino.h>

class BipolarStepper {
 public:
  BipolarStepper(uint16_t steps_set, int brka_set, int dira_set, int pwma_set, int brkb_set,
      int dirb_set, int pwmb_set);
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
  const static int NUM_STATES = 4;

  void doState(int state);
  const int brka, dira, pwma, brkb, dirb, pwmb;
  const uint16_t steps;
  int32_t position;
  int32_t target;
  bool enabled;
  int state;
  bool initialized;
};

#endif
