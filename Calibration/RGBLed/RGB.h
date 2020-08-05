
/*
 * RGB.h - RGB LED handler class
 * Created by JP Yepez, Jul 2020.
 * Victoria University of Wellington
*/

#ifndef RGB_h
#define RGB_h

#include "Arduino.h"

class RGB
{
private:
    int redPin;
    int greenPin;
    int bluePin;

public:
    RGB(int, int, int);

    void init();
    void init(int, int, int);
    void set(int, int, int);

    int getRed() { return redPin; };
};

#endif