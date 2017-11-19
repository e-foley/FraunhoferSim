#ifndef MASK_CONTROLLER_H_
#define MASK_CONTROLLER_H_

#include "stepper_controller.h"

class MaskController {
  public:
    enum class Direction {
      NONE,
      FORWARD,
      BACKWARD,
      AUTO
    };

    MaskController(StepperController* stepper_controller, float gear_ratio);
    // void initialize();
    void counterclockwise();
    void clockwise();
    void stop();
    float rotateTo(float mask_angle, Direction direction = Direction::AUTO);
    float rotateBy(float relative_angle);
    float getPosition() const;
    float getTarget() const;
    void setZero(float relative_angle);
    float maskToMotorAngle(float mask_angle) const;
    float motorToMaskAngle(float motor_angle) const;

  private:
    //
    static float wrapAngle(float nominal);
    float unwrapAngle(float wrapped_angle) const;
    static float wrappedDifference(float a, float b);


    StepperController* stepper_controller_;
    const float gear_ratio_;
    // Direction direction_;
    float target_;
};

#endif
