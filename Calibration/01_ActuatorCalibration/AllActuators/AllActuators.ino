// All Actuators
// Azure Talos Calibration Script

#include <AccelStepper.h>
#include <DynamixelSerial.h>
#include <Metro.h>

// Azure 1.1: Pickwheel
#define WDIR 25
#define WSTEP 26
#define WSLEEP 27
#define WMS2 28
#define WMS1 29
#define WMS0 30

// Azure 1.1: Lift
#define LDIR 4
#define LSTEP 5
#define LSLEEP 6
#define LMS2 7
#define LMS1 8
#define LMS0 9

// Dynamixel ID
#define MX64ID 1

// STEPPER SETUP
/////////////////

AccelStepper wheel(AccelStepper::DRIVER, WSTEP, WDIR);
AccelStepper lift(AccelStepper::DRIVER, LSTEP, LDIR);

Metro wMetro = Metro(1000);
Metro lMetro = Metro(2000);

int wTargets[] = {0, 800};
int lTargets[] = {0, 400};
uint32_t wIdx = 0;
uint32_t lIdx = 0;
boolean wIsAtTarget = true;
boolean lIsAtTarget = true;

bool wModes[] = {false, true, false};
bool lModes[] = {false, true, false};

// DYNAMIXEL SETUP
/////////////////////

// Timer
IntervalTimer dynaTimer;

int dynaTargets[] = {500, 800};
uint32_t dynaIdx = 0;

void setup() {
  
  // stepper motors
  initPins(wModes, lModes);
  wheel.setMaxSpeed(20000);
  wheel.setAcceleration(40000);
  lift.setMaxSpeed(20000);
  lift.setAcceleration(40000);

  // dynamixel
  Serial1.setTX(1);
  Serial1.setRX(0);
  pinMode(2, OUTPUT);
  Dynamixel.begin(1000000, 2, 4);
  Dynamixel.setAngleLimit(1, 250, 1200);
  dynaTimer.begin(dynaMove, 1000000);
}

void loop() {
  stpMove(lMetro, LSLEEP, lift, lTargets, lIsAtTarget, lIdx);
  stpMove(wMetro, WSLEEP, wheel, wTargets, wIsAtTarget, wIdx);

  lift.run();
  wheel.run();
}

// FUNCTIONS
///////////////

void initPins(bool wModes[], bool lModes[]) {
  pinMode(WSLEEP, OUTPUT);
  pinMode(WMS0, OUTPUT);
  pinMode(WMS1, OUTPUT);
  pinMode(WMS2, OUTPUT);

  digitalWrite(WMS0, wModes[0]);
  digitalWrite(WMS1, wModes[1]);
  digitalWrite(WMS2, wModes[2]);

  pinMode(LSLEEP, OUTPUT);
  pinMode(LMS0, OUTPUT);
  pinMode(LMS1, OUTPUT);
  pinMode(LMS2, OUTPUT);

  digitalWrite(LMS0, lModes[0]);
  digitalWrite(LMS1, lModes[1]);
  digitalWrite(LMS2, lModes[2]);
}

void stpMove(Metro &metro, int sleepPin, AccelStepper &stp, int targets[], bool &isAtTarget, uint32_t &idx) {
  // set stepper target every interval
  if (metro.check() == 1) {
    digitalWrite(sleepPin, HIGH);
    stp.moveTo(targets[idx % 2]);
    isAtTarget = false;
    idx++;
  }
  // disable stepper when at target
  if (stp.distanceToGo() == 0 && !isAtTarget) {
    digitalWrite(sleepPin, LOW);
    isAtTarget = true;
  }
}

void dynaMove()
{
    Dynamixel.moveSpeed(MX64ID, dynaTargets[dynaIdx % (sizeof(dynaTargets) / sizeof(dynaTargets[0]))], 32);
    Dynamixel.ledStatus(MX64ID, (1 + dynaIdx) % 2);
    dynaIdx++;
}
