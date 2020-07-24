/*
 * UServo.h - Chordophone servo motors class
 * Created by JP Yepez, Jul 2019.
 * Victoria University of Wellington
*/

#include "Arduino.h"
#include "UServo.h"

UServo::UServo(int servoPin)
{
    pin = servoPin;

    pwmState = LOW;
    z = 0;
}

void UServo::init()
{
    pinMode(pin, OUTPUT);
}

void UServo::pulse()
{
    pwmState = !pwmState;
    digitalWrite(pin, pwmState);
}

void UServo::move(int delayus)
{
    if (micros() >= z + delayus)
    {
        pulse();
        z = micros();
    }
}
