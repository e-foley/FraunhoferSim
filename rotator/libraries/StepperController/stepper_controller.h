#ifndef STEPPER_CONTROLLER_H_
#define STEPPER_CONTROLLER_H_

#include "bipolar_stepper.h"
#include "timer_one.h"

class StepperController {
  public:
    enum class Behavior {
      STOPPED,
      FORWARD,
      BACKWARD,
      TARGETING,
      REACHED_TARGET
    };

    StepperController(BipolarStepper* stepper, int16_t steps_per_rotation);

    void forward();
    void backward();
    void stop();
    float rotateTo(float angle);
    float rotateBy(float relative_angle);
    float getPosition() const;
    float getTarget() const;
    void setZero(float angle_relative_to_current = 0.0f);
    void update();
    int32_t degreesToSteps(float degrees) const;
    float stepsToDegrees(int32_t steps) const;

  private:
    BipolarStepper* const stepper_;
    const int16_t steps_per_rotation_;
    int32_t position_;
    float target_angle_;
    int32_t target_steps_;
    Behavior behavior_;
};

#endif
