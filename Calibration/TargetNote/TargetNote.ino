
// Protochord
// Dynamixel Calibration Script

#include <AccelStepper.h>
#include <DynamixelSerial.h>
#include <Metro.h>
#include "UServo.h"
#include "LedClass.h"

#define MX64ID 1

// PCB 1.0: Picker
#define DIR 24
#define STEP 25
#define SLEEP 26
#define MS0 28
#define MS1 29
#define MS2 30

// STATUS LED
//////////////
LedClass statusLed(32);

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
// int dynaTargets[] = {500, 1000};
int dynaTargets[] = {500, 800};
uint32_t idx = 0;

bool modes[] = {false, true, false};

// STEPPERS
AccelStepper stp(AccelStepper::DRIVER, STEP, DIR);
Metro stpMetro = Metro(500);
Metro servoMetro = Metro(6000);

int targets[] = {0, 160}; // Full turn at 1/32 mstep
uint32_t st_idx = 0;
boolean isAtTarget = true;

// SERVO
//////////////////
// servo range: 300-1200
// mute: 0

UServo clamper(33);
int clamperTargets[] = {0, 600};
uint32_t servoCounter = 0;


// PROGRAM
/////////////

void setup()
{
  statusLed.init(1000);

  Serial1.setTX(1);
  Serial1.setRX(0);
  pinMode(2, OUTPUT);
  Dynamixel.begin(1000000, 2, 4);
  Dynamixel.setAngleLimit(1, 250, 1200);

  dynaTimer.begin(dynaMove, 1000000);

  initPins(modes);

  stp.setMaxSpeed(20000);
  stp.setAcceleration(40000);

  clamper.init();
}

void loop()
{
  statusLed.blink();

  // steppers
  // set target every interval
  if (stpMetro.check() == 1) {
    digitalWrite(SLEEP, HIGH);
    stp.moveTo(targets[st_idx % 2]);
    isAtTarget = false;
    st_idx++;
  }

  // disable when at target
  if (stp.distanceToGo() == 0 && !isAtTarget) {
    digitalWrite(SLEEP, LOW);
    isAtTarget = true;
  }
  stp.run();

  // servos
  if (servoMetro.check() == 1) {
    servoCounter++;
  }

  // clamper
  clamper.move(clamperTargets[servoCounter % (sizeof(clamperTargets) / sizeof(clamperTargets[0]))]);
}

void dynaMove()
{
  //Dynamixel.moveSpeed(MX64ID, dynaTargets[idx % (sizeof(dynaTargets) / sizeof(dynaTargets[0]))], 64);
  Dynamixel.moveSpeed(MX64ID, dynaTargets[idx % (sizeof(dynaTargets) / sizeof(dynaTargets[0]))], 16);
  Dynamixel.ledStatus(MX64ID, (1 + idx) % 2);
  idx++;
}

void initPins(bool modes[]) {
  pinMode(SLEEP, OUTPUT);
  pinMode(MS0, OUTPUT);
  pinMode(MS1, OUTPUT);
  pinMode(MS2, OUTPUT);

  digitalWrite(MS0, modes[0]);
  digitalWrite(MS1, modes[1]);
  digitalWrite(MS2, modes[2]);
}
