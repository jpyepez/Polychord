// Actuator Notes
// Azure Talos Keyboard Input Script

#include <AccelStepper.h>
#include <DynamixelSerial.h>
#include <Ramp.h>
#include "UServo.h"
#include "NoteHandler.h"
#include "KeyInput.h"

// I/O SETUP
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

// KeyInput setup
KeyInput key;
int keyVal;

// NoteHandler setup
const int NOTES = 6;
int midiNotes[NOTES] = {59, 60, 61, 62, 63, 64};
int pos[NOTES - 1] = {500, 600, 700, 800, 900}; // Arm position array does not include open string
int clPos[NOTES] = {0, 550, 550, 550, 550, 550};
NoteHandler armHandler(midiNotes + 1, pos, NOTES - 1);
NoteHandler clamperHandler(midiNotes, clPos, NOTES);

// CLAMPER SETUP
/////////////////
// servo range: 300-1200
// open: 0
// clamper: clamp < 750 < damp
// pmute: 750 < mute

UServo clServo(34);
rampInt clRamp;
uint32_t clVal;

UServo pmServo(33);
bool pmuteOn;

// STEPPER SETUP
/////////////////

AccelStepper wheel(AccelStepper::DRIVER, WSTEP, WDIR);
int wPins[] = {WMS0, WMS1, WMS2};
bool wModes[] = {false, true, false};
bool tremOn;

AccelStepper lift(AccelStepper::DRIVER, LSTEP, LDIR);
int lPins[] = {LMS0, LMS1, LMS2};
bool lModes[] = {false, true, false};

void setup()
{
  // servomotors init
  clServo.init();
  clRamp.go(0);
  pmServo.init();
  pmuteOn = false;

  // stepper motors init
  initPins(WSLEEP, wPins, wModes);
  wheel.setMaxSpeed(20000);
  wheel.setAcceleration(40000);
  tremOn = false;

  initPins(LSLEEP, lPins, lModes);
  lift.setMaxSpeed(20000);
  lift.setAcceleration(40000);

  // dynamixel init
  Serial1.setTX(1);
  Serial1.setRX(0);
  pinMode(2, OUTPUT);
  Dynamixel.begin(1000000, 2, 4);
  Dynamixel.setAngleLimit(1, 250, 1200);

  // print instructions
  Serial.println("Input MIDI notes:");
  Serial.println("(59--64)");
  Serial.println("Palm mute: 11-on, 10-off");
  Serial.println("Tremolo picking: 21-on, 20-off");
}

void loop()
{
  // get keyboard input
  key.serialRead();
  key.printData();
  key.getDataInt(&keyVal);

  // handle input (pluck)
  if (key.checkNewData())
  {
    if (keyVal == 10) pmuteOn = false;        // mute off
    else if (keyVal == 11) pmuteOn = true;    // mute on
    else if (keyVal == 20) tremOn = false;    // tremolo off
    else if (keyVal == 21) tremOn = true;      // tremolo on
    else {                                    // pluck
      armHandler.applyPos(keyVal, dynaMove);
      clamperHandler.applyPos(keyVal, setClamper);
      uint32_t pickSpeed =  tremOn ? 800 : 80;
      Serial.println(pickSpeed);
      stpMove(wheel, WSLEEP, pickSpeed);

      // ramp to release
      clRamp.go(0);
      clRamp.go(100, 500, LINEAR, ONCEFORWARD);
    }
  }

  // clear keyboard input
  key.clearData();

  // stop plucker
  stpStop(wheel, WSLEEP);

  pmute();
  clamp();

  wheel.run();
  lift.run();
}

// FUNCTIONS
///////////////

void initPins(int sleepPin, int msPins[], bool msModes[])
{
  pinMode(WSLEEP, OUTPUT);
  pinMode(WSLEEP, LOW);

  for (int i = 0; i < 3; i++)
  {
    pinMode(msPins[i], OUTPUT);
    digitalWrite(msPins[i], msModes[i]);
  }
}

void stpMove(AccelStepper &stp, int sleepPin, int dist)
{
  digitalWrite(sleepPin, HIGH);
  stp.move(dist);
}

void stpStop(AccelStepper &stp, int sleepPin)
{
  if (stp.distanceToGo() == 0)
  {
    digitalWrite(sleepPin, LOW);
  }
}

void dynaMove(int target)
{
  Dynamixel.moveSpeed(MX64ID, target, 256);
  //Dynamixel.ledStatus(MX64ID, 1);
}

void setClamper(int target) {
  clVal = target;
}

void clamp()
{

  int clCount = clRamp.update();

  if (clRamp.isFinished())
  {
    clServo.move(0);
  }
  else
  {
    clServo.move(clVal);
  }

  // Serial.print(clCount);
  // Serial.print(", ");
  // Serial.print(clRamp.isRunning());
  // Serial.print(", ");
  // Serial.println(clRamp.isFinished());
}

void pmute() {
  if (!pmuteOn) {
    pmServo.move(0);
  } else {
    if (clRamp.isRunning()) pmServo.move(1200); // only mute if plucking
  }
}
