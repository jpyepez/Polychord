
#include "KeyInput.h"

KeyInput key;
int val; // output value

void setup()
{
    Serial.begin(9600);
    Serial.println("Input integers:");
}

void loop()
{
    key.serialRead();
    //key.printData();
    key.getDataInt(&val);
    if (key.checkNewData())
        Serial.println(val);
    key.clearData();
}
