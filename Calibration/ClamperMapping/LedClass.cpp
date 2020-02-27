
/*
 * Led.h - LED handler class
 * Created by JP Yepez, Aug 2019.
 * Victoria University of Wellington
*/

#include "Arduino.h"
#include "LedClass.h"

LedClass::LedClass(int ledPin)
{
    pin = ledPin;
    ledStatus = false;
}

void LedClass::setStatus(bool newStatus)
{
    ledStatus = newStatus;
}

bool LedClass::getStatus()
{
    return ledStatus;
}

void LedClass::setBlinkInterval(int blinkIntervalMillis)
{
    blinkInterval = blinkIntervalMillis;
}

int LedClass::getBlinkInterval()
{
    return blinkInterval;
}

void LedClass::init()
{
    pinMode(pin, OUTPUT);
    z = millis();
    blinkInterval = 0;
}

void LedClass::init(int blinkIntervalMillis)
{
    pinMode(pin, OUTPUT);
    z = millis();
    setBlinkInterval(blinkIntervalMillis);
}

void LedClass::enable(bool newStatus)
{
    setStatus(newStatus);
    digitalWrite(pin, newStatus);
}

void LedClass::blink()
{
    if (millis() >= (z + getBlinkInterval()))
    {
        enable(!getStatus());
        z = millis();
    }
}
