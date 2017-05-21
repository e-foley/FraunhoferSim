#include <BipolarStepper.h>
#include <Math.h>
#include <Arduino.h>

BipolarStepper::BipolarStepper(uint16_t steps_set, int BRKA_set, int DIRA_set, int PWMA_set, int BRKB_set, int DIRB_set, int PWMB_set)
{
	steps = steps_set;
	BRKA = BRKA_set;
	DIRA = DIRA_set;
	PWMA = PWMA_set;
	BRKB = BRKB_set;
	DIRB = DIRB_set;
	PWMB = PWMB_set;
	pinMode(BRKA, OUTPUT);
	pinMode(DIRA, OUTPUT);
	pinMode(PWMA, OUTPUT);
	pinMode(BRKB, OUTPUT);
	pinMode(DIRB, OUTPUT);
	pinMode(PWMB, OUTPUT);
	enabled = false;
	target = 0;
	//direction = BIDIRECTIONAL;
	state = 0;
	doState(state);
	delay(200);
	zero();
}

void BipolarStepper::enable()
{
	enabled = true;
}

void BipolarStepper::disable()
{
	enabled = false;
}

bool BipolarStepper::isEnabled()
{
	return enabled;
}

// void BipolarStepper::forceDirection(int direction_forcing)
// {
	// direction = direction_forcing;
// }

//void BipolarStepper::setTarget(uint16_t target_setting)
void BipolarStepper::setTarget(int32_t target_setting)
{
	target = target_setting;
}

//uint16_t BipolarStepper::getTarget()
int32_t BipolarStepper::getTarget()
{
	return target;
}

float BipolarStepper::getTargetDegrees()
{
	return ticksToDegrees(target);
}

void BipolarStepper::setTargetDegrees(float target_setting)
{
	target = degreesToTicks(target_setting);
}

//uint16_t BipolarStepper::getPosition()
int32_t BipolarStepper::getPosition()
{
	return position;
}

float BipolarStepper::getPositionDegrees()
{
	return ticksToDegrees(position);
}

//void BipolarStepper::setCurrentPosition(uint16_t position_setting)
void BipolarStepper::setCurrentPosition(int32_t position_setting)
{
	position = position_setting;
}

void BipolarStepper::setCurrentPositionDegrees(float position_setting)
{
	position = degreesToTicks(position_setting);
}

void BipolarStepper::zero()
{
	setCurrentPosition(0);
}

// uint16_t BipolarStepper::degreesToTicks(float degrees)
// {
	// if (degrees >= 0.0f) {
		// return (uint16_t)(round(fmod(degrees, 360.0f) / 360.0f * steps));
	// } else {
		// return (uint16_t)(round(fmod(360.0f - fmod(-degrees, 360.0f), 360.0f) / 360.0f * steps)); // Outer mod function is to ensure inputs like -360.0f return 0 instead of steps
	// }
// }

int32_t BipolarStepper::degreesToTicks(float degrees)
{
	return (int32_t)(round(degrees / 360.0f * steps));
}

//float BipolarStepper::ticksToDegrees(uint16_t ticks)
float BipolarStepper::ticksToDegrees(int32_t ticks)
{
	return 360.0f * ticks / steps;
}

void BipolarStepper::stepForward()
{
	if (!enabled) {
		return;
	}
	
	state = (state + 1) % NUM_STATES;
	doState(state);
	//position = (position + 1) % steps;
	position++;
}

void BipolarStepper::stepBackward()
{
	if (!enabled) {
		return;
	}
	
	state = (state + NUM_STATES - 1) % NUM_STATES;
	doState(state);
	//position = (position + steps - 1) % steps;
	position--;
}

// void BipolarStepper::stepTowardTarget()
// {
	// if (!enabled || position == target) {
		// return;
	// }
	
	// switch (direction) {
		// case FORWARD:
			// stepForward();
		// break;
		// case BACKWARD:
			// stepBackward();
		// break;
		// case BIDIRECTIONAL:
			// if ((position > target && position - target > steps / 2) || (position < target && target - position <= steps / 2)) {
				// stepForward();
			// } else {
				// stepBackward();
			// }
		// break;
		// default:
			// return;
		// break;
	// }
// }

void BipolarStepper::stepTowardTarget()
{
	if (!enabled || position == target) {
		return;
	}
	
	if (position > target) {
		stepBackward();
	} else if (position < target) {
		stepForward();
	}
}

// void BipolarStepper::step()
// {
	// if (!enabled) {
		// return;
	// }
	
	// switch (direction) {
		// case FORWARD:
			// stepForward();
		// break;
		// case BACKWARD:
			// stepBackward();
		// break;
		// default:
			// stepForward();
		// break;
	// }
// }

void BipolarStepper::doState(int state)
{
	state = state % 4;
	switch (state) {
		case 0:
			digitalWrite(BRKA, LOW);
			digitalWrite(BRKB, HIGH);
			digitalWrite(DIRA, HIGH);
			analogWrite(PWMA, 255);
		break;
		case 1:
			digitalWrite(BRKA, HIGH);
			digitalWrite(BRKB, LOW);
			digitalWrite(DIRB, LOW);
			analogWrite(PWMB, 255);
		break;
		case 2:
			digitalWrite(BRKA, LOW);
			digitalWrite(BRKB, HIGH);
			digitalWrite(DIRA, LOW);
			analogWrite(PWMA, 255);
		break;
		case 3:
			digitalWrite(BRKA, HIGH);
			digitalWrite(BRKB, LOW);
			digitalWrite(DIRB, HIGH);
			analogWrite(PWMB, 255);
		break;
	}

	// switch (state) {
		// case 0:
			// digitalWrite(pin_1, HIGH);
			// digitalWrite(pin_2, LOW);
			// digitalWrite(pin_3, HIGH);
			// digitalWrite(pin_4, LOW);
		// break;
		// case 1:
			// digitalWrite(pin_1, LOW);
			// digitalWrite(pin_2, LOW);
			// digitalWrite(pin_3, HIGH);
			// digitalWrite(pin_4, LOW);
		// break;
		// case 2:
			// digitalWrite(pin_1, LOW);
			// digitalWrite(pin_2, HIGH);
			// digitalWrite(pin_3, HIGH);
			// digitalWrite(pin_4, LOW);
		// break;
		// case 3:
			// digitalWrite(pin_1, LOW);
			// digitalWrite(pin_2, HIGH);
			// digitalWrite(pin_3, LOW);
			// digitalWrite(pin_4, LOW);
		// break;
		// case 4:
			// digitalWrite(pin_1, LOW);
			// digitalWrite(pin_2, HIGH);
			// digitalWrite(pin_3, LOW);
			// digitalWrite(pin_4, HIGH);
		// break;
		// case 5:
			// digitalWrite(pin_1, LOW);
			// digitalWrite(pin_2, LOW);
			// digitalWrite(pin_3, LOW);
			// digitalWrite(pin_4, HIGH);
		// break;
		// case 6:
			// digitalWrite(pin_1, HIGH);
			// digitalWrite(pin_2, LOW);
			// digitalWrite(pin_3, LOW);
			// digitalWrite(pin_4, HIGH);
		// break;
		// case 7:
			// digitalWrite(pin_1, HIGH);
			// digitalWrite(pin_2, LOW);
			// digitalWrite(pin_3, LOW);
			// digitalWrite(pin_4, LOW);
		// break;
		// default:
			// digitalWrite(pin_1, HIGH);
			// digitalWrite(pin_2, HIGH);
			// digitalWrite(pin_3, HIGH);
			// digitalWrite(pin_4, HIGH);
		// break;
	// }
}

int BipolarStepper::getState()
{
	return state;
}