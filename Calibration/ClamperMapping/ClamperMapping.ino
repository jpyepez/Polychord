
// Protochord
// Steppers + Servo (Clamper) + Servo (Palm Mute)

// SKETCH SETTINGS
//////////////////

#include <DynamixelSerial.h>
#include <AccelStepper.h>
#include <Metro.h>
#include "UServo.h"
#include "LedClass.h"

#define MX64ID 1
#define WSLEEP 26
#define WSTEP 25
#define WDIR 24
#define MS0 30
#define MS1 29
#define MS2 28

// TIMERS
///////////
Metro wheelMetro = Metro(250); // in millis
Metro clamperMetro = Metro(1000);
IntervalTimer myTimer;

// STATUS LED
/////////////////
LedClass statusLed(32);

// DYNAMIXEL
/////////////////
int dynaTargets[] = {400, 900};
uint32_t idx = 0;
int currentTarget;

// lookup table
// 2m 1900
// 2M 2025
// 3m 2100
// 3M 2175
// 4P 2230
// 4+ 2285
// 5P 2340

// STEPPERS
//////////////////
AccelStepper wheel(AccelStepper::DRIVER, WSTEP, WDIR);

bool wheelModes[] = {true, false, true};
//int wTarget = 6400; // full spin
int wTarget = 640;
uint32_t wIdx = 0;
bool wAtTarget = true;

// SERVO
//////////////////
// servo range: 300-1200
// mute: 0

UServo clamper(33);
// int clamperTargets[] = {0, 600, 600, 600, 600, 600, 575, 550};
// int clamperTargets[] = {0, 600};

int clamperCounter = 0; // use to alternate between targets

// PROGRAM
////////////

void setup()
{
  statusLed.init(10000);

  initWheel(wheelModes);
  wheel.setMaxSpeed(80000);
  wheel.setAcceleration(160000);

  clamper.init();

  // Dynamixel setup
  Serial1.setTX(1);
  Serial1.setRX(0);
  pinMode(2, OUTPUT);
  Dynamixel.begin(1000000, 2, 4);

  myTimer.begin(dynaMove, 4000000);
}

void loop()
{
  //statusLed.blink();

  // wheel process
  if (wheelMetro.check() == 1) {
    digitalWrite(WSLEEP, HIGH);
    wheel.move(wTarget);
    wAtTarget = false;
  }
  if (wheel.distanceToGo() == 0 && !wAtTarget) {
    digitalWrite(WSLEEP, LOW);
    wAtTarget = true;
  }
  wheel.run();

  // clamper process
  if (clamperMetro.check() == 1) clamperCounter++;
  clamper.move(map(currentTarget, 400, 900, 575, 450));
}

// FUNCTIONS
//////////////

void dynaMove()
{
  currentTarget = dynaTargets[idx % (sizeof(dynaTargets) / sizeof(dynaTargets[0]))];
  Dynamixel.moveSpeed(MX64ID, currentTarget, 32);
  Dynamixel.ledStatus(1, (1 + idx) % 2);
  idx++;
}

void initWheel(bool modes[]) {
  pinMode(WSLEEP, OUTPUT);
  pinMode(MS0, OUTPUT);
  pinMode(MS1, OUTPUT);
  pinMode(MS2, OUTPUT);

  digitalWrite(MS0, modes[0]);
  digitalWrite(MS1, modes[1]);
  digitalWrite(MS2, modes[2]);

}
