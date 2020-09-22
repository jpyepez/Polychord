
#include "KeyInput.h"

KeyInput::KeyInput() : newData(false)
{
}

void KeyInput::serialRead()
{
    static byte ndx = 0;
    char endMarker = '\n';
    char rc;

    while (Serial.available() > 0 && newData == false)
    {
        rc = Serial.read();

        if (rc != endMarker)
        {
            receivedChars[ndx] = rc;
            ndx++;
            if (ndx >= numChars)
            {
                ndx = numChars - 1;
            }
        }
        else
        {
            receivedChars[ndx] = '\0';
            ndx = 0;
            newData = true;
        }
    }
}

void KeyInput::printData()
{
    if (newData)
    {
        Serial.print("Received: ");
        Serial.println(receivedChars);
    }
}

void KeyInput::getDataInt(int *outVal)
{
    if (newData)
    {
        
        *outVal = atoi(receivedChars);
    }
}

void KeyInput::clearData()
{
    newData = false;
}
