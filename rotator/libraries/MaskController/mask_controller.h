#ifndef MASK_CONTROLLER_H_
#define MASK_CONTROLLER_H_

#include "stepper_controller.h"

class MaskController {
  public:
    enum class Direction {
      NONE,
      FORWARD,
      BACKWARD,
      BIDIRECTIONAL
    };

    MaskController(StepperController* stepper, float gear_ratio);
    void initialize();
    void step();
    void setPreferredDirection(Direction direction);
    Direction getPreferredDirection() const;

  private:
    StepperController* stepper_;
    Direction direction_;
    float angle_;
    const float gear_ratio_;
};

#endif
