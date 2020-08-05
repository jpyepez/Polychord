
/*
 * RGBLed.h - RGB LED handler class
 * Created by JP Yepez, Jul 2020.
 * Victoria University of Wellington
*/

#include "RGB.h"
#include <Metro.h>

Metro rgbMetro = Metro(1000);

RGB rgb(37, 36, 35);
uint32_t rgbCounter = 0;

void setup()
{
    //rgb.init();
    Serial.begin(9600);
    pinMode(37, OUTPUT);
    pinMode(36, OUTPUT);
    pinMode(35, OUTPUT);
}

void loop() {
  analogWrite(37, 255);
  analogWrite(36, 255);
  analogWrite(35, 255);
  delay(100);
}

//void loop()
//{
//    if (rgbMetro.check() == 1)
//    {
//        rgbCounter++;
//        rgbCounter = rgbCounter % 7;
//        Serial.println(rgb.getRed());
//    }
//
//    switch (rgbCounter)
//    {
//
//    case 0:
//        rgb.set(255, 0, 0);
//        break;
//    case 1:
//        rgb.set(0, 255, 0);
//        break;
//    case 2:
//        rgb.set(0, 0, 255);
//        break;
//    case 3:
//        rgb.set(255, 0, 255);
//        break;
//    case 4:
//        rgb.set(0, 255, 255);
//        break;
//    case 5:
//        rgb.set(255, 0, 255);
//        break;
//    case 6:
//        //rgb.set(0, 0, 0);
//        break;
//    default:
//        break;
//    }
//}
