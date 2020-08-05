
/*
 * RGB.h - RGB LED handler class
 * Created by JP Yepez, Jul 2020.
 * Victoria University of Wellington
*/

#include "Arduino.h"
#include "RGB.h"

RGB::RGB(int rPin, int gPin, int bPin)
{

    redPin = rPin;
    greenPin = gPin;
    bluePin = bPin;
}

void RGB::init()
{
    pinMode(redPin, OUTPUT);
    pinMode(greenPin, OUTPUT);
    pinMode(bluePin, OUTPUT);
}

void RGB::init(int rPin, int gPin, int bPin)
{
    pinMode(rPin, OUTPUT);
    pinMode(gPin, OUTPUT);
    pinMode(bPin, OUTPUT);
}

void RGB::set(int rValue, int gValue, int bValue)
{
    analogWrite(redPin, rValue);
    analogWrite(greenPin, gValue);
    analogWrite(bluePin, bValue);
}
