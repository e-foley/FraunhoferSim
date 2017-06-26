#ifndef BIPOLAR_STEPPER_H_
#define BIPOLAR_STEPPER_H_

#include <Arduino.h>

class BipolarStepper {
 public:
  // const static int FORWARD = 1;
  // const static int BIDIRECTIONAL = 0;
  // const static int BACKWARD = -1;
  BipolarStepper(uint16_t steps_set, int BRKA_set, int DIRA_set, int PWMA_set, int BRKB_set,
      int DIRB_set, int PWMB_set);
  void initialize();
  void enable();
  void disable();
  bool isEnabled();
  //void forceDirection(int direction);
  void setTarget(int32_t target_setting);
  void setTargetDegrees(float target_setting);
  int32_t getTarget();
  float getTargetDegrees();
  int32_t getPosition();
  float getPositionDegrees();
  void setCurrentPosition(int32_t position_set);
  void setCurrentPositionDegrees(float position_set);
  void zero();
  int32_t degreesToTicks(float degrees);
  float ticksToDegrees(int32_t ticks);
  void stepForward();
  void stepBackward();
  //void step();
  void stepTowardTarget();
  int getState();

 private:
  const static int NUM_STATES = 8;
  
  void doState(int state);
  int BRKA, DIRA, PWMA, BRKB, DIRB, PWMB;
  uint16_t steps;
  int32_t position;
  int32_t target;
  bool enabled;
  //int direction;
  int state;
  bool initialized;
};

#endif
