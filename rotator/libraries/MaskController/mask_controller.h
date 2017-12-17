#ifndef MASK_CONTROLLER_H_
#define MASK_CONTROLLER_H_

#include "stepper_controller.h"

class MaskController {
  public:
    enum class Direction {
      NONE,
      COUNTERCLOCKWISE,
      CLOCKWISE,
      AUTO
    };

    MaskController(volatile StepperController* stepper_controller, float gear_ratio);
    void counterclockwise();
    void clockwise();
    void stop();
    float rotateTo(float mask_angle, Direction direction = Direction::AUTO);
    float rotateBy(float relative_angle);
    float getPosition() const;
    float getTarget() const;
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
