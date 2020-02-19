
// Protochord
// Clamper Calibration Script

#include <Metro.h>
#include "UServo.h"

// TIMER
/////////
Metro servoMetro = Metro(1000);

// SERVO
//////////////////
// servo range: 300-1200
// mute: 0

UServo clamper(33);
int clamperTargets[] = {750};
// int clamperTargets[] = {300, 1200};
// int clamperTargets[] = {0, 600, 600, 600, 600, 600, 575, 550};

uint32_t servoCounter = 0;

// SCRIPT
//////////

void setup()
{
    clamper.init();
}

void loop()
{
    if (servoMetro.check() == 1)
        servoCounter++;
    clamper.move(clamperTargets[servoCounter % (sizeof(clamperTargets) / sizeof(clamperTargets[0]))]);
}