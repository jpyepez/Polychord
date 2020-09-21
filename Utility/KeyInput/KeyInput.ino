
#include "KeyInput.h"

KeyInput key;

void setup()
{
    Serial.begin(9600);
    Serial.println("Input integers:");
}

void loop()
{
    key.serialRead();
    key.printData();
    key.clearData();
}
