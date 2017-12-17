#ifndef STEPPER_CONTROLLER_H_
#define STEPPER_CONTROLLER_H_

#include "bipolar_stepper.h"

class StepperController {
  public:
    // Use int as underlying type so that Behavior variables can't get glitched by interrupts.
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
    void setTargetReachedCallback(void (*callback)(void)) volatile;
    float getPosition() const volatile;
    float getTarget() const volatile;
    void setZero(float angle_relative_to_current = 0.0f) volatile;
    void update() volatile;
    int32_t degreesToSteps(float degrees) const volatile;
    float stepsToDegrees(int32_t steps) const volatile;

  private:
    // Below are const so that we can poll position_ safely in getPosition();
    inline void disableInterrupt() const volatile;
    inline void enableInterrupt() const volatile;

    BipolarStepper* const stepper_;
    const int16_t steps_per_rotation_;
    volatile int32_t position_;
    float target_angle_;
    int32_t target_steps_;
    volatile Behavior behavior_;
    void (*target_reached_callback_)(void);
};

#endif
