
/*
 * Led.h - LED handler class
 * Created by JP Yepez, Aug 2019.
 * Victoria University of Wellington
*/

#ifndef Led_h
#define Led_h

#include "Arduino.h"

class LedClass
{
private:
    int pin;
    bool ledStatus;

    int blinkInterval; // 0 - blink disabled
                       // >0 - blink interval in millis
    uint32_t z;        // time of last blink

public:
    LedClass(int);

    void setStatus(bool);
    bool getStatus();
    void setBlinkInterval(int);
    int getBlinkInterval();

    void init();
    void init(int);
    void enable(bool);
    void blink();
};

#endif
