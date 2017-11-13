#ifndef STEPPER_CONTROLLER_H_
#define STEPPER_CONTROLLER_H_

#include "bipolar_stepper.h"
#include "timer_one.h"

class StepperController {
  public:
    enum class Direction {
      NONE,
      FORWARD,
      BACKWARD,
      EITHER
    };

    StepperController(BipolarStepper* stepper, int steps_per_rotation, TimerOne* timer,
        uint32_t step_period_us);

    void initialize();

    float rotateTo(float angle, Direction direction);

  private:
    static BipolarStepper* stepper_;
    static void update();

    // BipolarStepper* stepper_;
    int steps_per_rotation_;
    TimerOne* timer_;
    uint32_t step_period_us_;
    bool initialized_;
};

#endif
