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
    float rotateTo(float angle, Direction direction);

  private:
    BipolarStepper* stepper_;
    int steps_per_rotation_;
    TimerOne* timer_;
    uint32_t step_period_us_;
};
