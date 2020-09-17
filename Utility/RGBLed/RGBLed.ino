
/*
 * RGBLed.h - RGB LED handler class
 * Created by JP Yepez, Jul 2020.
 * Victoria University of Wellington
*/

#include "RGB.h"
#include <Metro.h>

#define RPIN 36
#define GPIN 37
#define BPIN 35

Metro rgbMetro = Metro(2000);

RGB rgb(RPIN, GPIN, BPIN);
uint32_t rgbCounter = 0;

void setup()
{
    rgb.init();
    Serial.begin(9600);
}

void loop()
{
    if (rgbMetro.check() == 1)
    {

        switch (rgbCounter)
        {

        case 0:
            rgb.set(255, 0, 0);
            break;
        case 1:
            rgb.set(0, 255, 0);
            break;
        case 2:
            rgb.set(0, 0, 255);
            break;
        case 3:
            rgb.set(255, 0, 255);
            break;
        case 4:
            rgb.set(0, 255, 255);
            break;
        case 5:
            rgb.set(255, 255, 0);
            break;
        case 6:
            rgb.set(0, 0, 0);
            break;
        default:
            break;
        }

        // monitor
        Serial.print(rgb.getRed());
        Serial.print(", ");
        Serial.print(rgb.getGreen());
        Serial.print(", ");
        Serial.println(rgb.getBlue());

        // counter
        rgbCounter++;
        rgbCounter = rgbCounter % 7;
    }
}
