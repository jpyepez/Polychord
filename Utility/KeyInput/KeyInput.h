
/*
 * KeyInput.h - Keyboard input class
 * Created by JP Yepez, Sep 2020.
 * Victoria University of Wellington
*/

#ifndef KeyInput_h
#define KeyInput_h

#include "Arduino.h"

class KeyInput
{
private:
    static const byte numChars = 32;
    char receivedChars[32];
    bool newData;

public:
    KeyInput();

    void serialRead();
    void printData();
    uint32_t getDataInt();
    void clearData();
};

#endif
