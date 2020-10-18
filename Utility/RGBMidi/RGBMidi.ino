
#include "RGB.h"

#define RPIN 36
#define GPIN 37
#define BPIN 35

RGB rgb(RPIN, GPIN, BPIN);

void setup()
{
  rgb.init();
  rgb.set(0, 0, 0);

  Serial.begin(9600);
  usbMIDI.setHandleNoteOn(rgbOn);
  usbMIDI.setHandleNoteOff(rgbOff);
}

void loop()
{
  usbMIDI.read();
}

void rgbOn(byte channel, byte note, byte velocity)
{
  if (note == 60)
  {
    rgb.setRed(255);
  }
  else if (note == 61)
  {
    rgb.setGreen(255);
  }
  else if (note == 62)
  {
    rgb.setBlue(255);
  }
  printRGB();
}

void rgbOff(byte channel, byte note, byte velocity)
{
  if (note == 60)
  {
    rgb.setRed(0);
  }
  else if (note == 61)
  {
    rgb.setGreen(0);
  }
  else if (note == 62)
  {
    rgb.setBlue(0);
  }
  printRGB();
}

void printRGB() {
  Serial.print("RGB: ");
  Serial.print(rgb.getRed());
  Serial.print(",");
  Serial.print(rgb.getGreen());
  Serial.print(",");
  Serial.println(rgb.getBlue());
}
