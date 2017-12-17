#ifndef MASK_CONTROLLER_H_
#define MASK_CONTROLLER_H_

#include "stepper_controller.h"

class MaskController {
  public:
    enum class Direction {
      NONE,
      FORWARD,
      REVERSE,
      AUTO
    };

    MaskController(volatile StepperController* stepper_controller, float gear_ratio);
    void forward();
    void reverse();
    void stop();
    float rotateTo(float mask_angle, Direction direction = Direction::AUTO,
        bool wrap_result = true);
    float rotateBy(float relative_angle, bool wrap_result = true);
    float getPosition(bool wrap_result = true) const;
    float getTarget(bool wrap_result = true) const;
    void setZero(float relative_angle = 0.0f);
    float maskToMotorAngle(float mask_angle) const;
    float motorToMaskAngle(float motor_angle) const;

  private:
    // Returns any absolute angle on [0, 360)
    static float wrapAngle(float nominal);

    volatile StepperController* const stepper_controller_;
    const float gear_ratio_;
    float target_;
};

#endif
