#ifndef STEPPER_CONTROLLER_H_
#define STEPPER_CONTROLLER_H_

#include "bipolar_stepper.h"
#include "timer_one.h"

class StepperController {
  public:
    enum class Behavior : int {
      STOPPED,
      FORWARD,
      REVERSE,
      TARGETING,
      REACHED_TARGET
    };

    StepperController(BipolarStepper* stepper, int16_t steps_per_rotation);

    void forward() volatile;
    void reverse() volatile;
    void stop() volatile;
    float rotateTo(float angle) volatile;
    float rotateBy(float relative_angle) volatile;
    float getPosition() const volatile;
    float getTarget() const volatile;
    void setZero(float angle_relative_to_current = 0.0f) volatile;
    void update() volatile;
    int32_t degreesToSteps(float degrees) const volatile;
    float stepsToDegrees(int32_t steps) const volatile;

  private:
    BipolarStepper* const stepper_;
    const int16_t steps_per_rotation_;
    volatile int32_t position_;
    float target_angle_;
    int32_t target_steps_;
    volatile Behavior behavior_;
};

#endif
