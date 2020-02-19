
/*
 * UServo.h - Chordophone servo motors class
 * Created by JP Yepez, Jul 2019.
 * Victoria University of Wellington
*/

#ifndef UServo_h
#define UServo_h

#include "Arduino.h"

// Servo PWM range: 300 - 1200 us

class UServo
{
private:
    int pin;
    bool pwmState;
    unsigned long z; // last reset

public:
    UServo(int);

    void init();
    void pulse();
    void move(int);
};

#endif
