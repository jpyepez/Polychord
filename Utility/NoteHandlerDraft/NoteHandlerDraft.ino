
#include "NoteHandler.h"
#include <Metro.h>

// TODO: callbacks or functions

const int PSIZE = 5;
int midi[PSIZE] = {60, 61, 62, 63, 64};
int pos[PSIZE] = {1000, 1100, 1200, 1300, 1400};
NoteHandler noteHandler(midi, pos, PSIZE);

Metro metro = Metro(1000);

// Serial input
const byte numChars = 32;
char receivedChars[numChars];
bool newData = false;

void setup()
{
    Serial.begin(9600);
    Serial.println("Note Handler Start");
    Serial.println("Input integers:");
}

void loop()
{
    serialRead();
    parseAndPrintData();
    //if (metro.check() == 1)
    //{
    //    Serial.println(noteHandler.lookupPos(60));
    //}
}

void serialRead()
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

void printInt(int x)
{
    Serial.println(x);
}

void parseAndPrintData()
{
    if (newData == true)
    {
        // Monitor serial
        Serial.print("Received: ");
        Serial.println(receivedChars);

        // Note Handler Lookup
        int val = atoi(receivedChars);
        noteHandler.applyPos(val, printInt);

        newData = false;
    }
}
