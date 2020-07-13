
// Protochord
// Dynamixel Calibration Script

#include <DynamixelSerial.h>
#include <Metro.h>

#define MX64ID 1

// TIMER
//////////
IntervalTimer dynaTimer;

// ROBOT ARM
/////////////
// Setup:
// * Make sure the Dynamixel disk indicators dots are aligned
// * Use RoboPlus App > Dynamixel Wizard
// * Select port (COM12, usually)
// * Search using DXL 1.0 and 57142 bps (default)
// * Select [ID:XXX]MX-64
// * Set ID and 1000000 bps

// FIX
// * Range: 500 (for now, e.g. 250--750)
// * CW Angle Limit: 150--400
// * CCW Angle Limit: 650--900
// * Torque Limit: 1023

// TODO: Use variables to set ranges/offsets for each arm

// DYNAMIXEL
/////////////
// int dynaTargets[] = {250, 1000};
int dynaTargets[] = {500, 1000};
uint32_t idx = 0;

// PROGRAM
/////////////

void setup()
{
    Serial1.setTX(1);
    Serial1.setRX(0);
    pinMode(2, OUTPUT);
    Dynamixel.begin(1000000, 2, 4);
    Dynamixel.setAngleLimit(1, 250, 1200);

    dynaTimer.begin(dynaMove, 1000000);
}

void loop()
{
}

void dynaMove()
{
    //Dynamixel.moveSpeed(MX64ID, dynaTargets[idx % (sizeof(dynaTargets) / sizeof(dynaTargets[0]))], 64);
    Dynamixel.moveSpeed(MX64ID, dynaTargets[idx % (sizeof(dynaTargets) / sizeof(dynaTargets[0]))], 128);
    Dynamixel.ledStatus(MX64ID, (1 + idx) % 2);
    idx++;
}
