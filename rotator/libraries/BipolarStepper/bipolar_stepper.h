#ifndef BIPOLAR_STEPPER_H_
#define BIPOLAR_STEPPER_H_

#include <Arduino.h>

class BipolarStepper {
 public:
  BipolarStepper(int brka, int dira, int pwma, int brkb, int dirb, int pwmb);
  ~BipolarStepper();
  void initialize();
  bool isInitialized() const;
  void enable();
  void disable();
  bool isEnabled() const;
  void stepForward();
  void stepBackward();

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
  // Other status variables.
  int state_;
  bool initialized_;
  bool enabled_;
};

#endif
