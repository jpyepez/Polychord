// 03_ActuatorMIDI
// Azure Talos MIDI Integration

#include <AccelStepper.h>
#include <DynamixelSerial.h>
#include <Ramp.h>
#include <Bounce.h>
#include "UServo.h"
#include "NoteHandler.h"
#include "RGB.h"

// String Unit Setup
#define UNIT_ID 1

// RGB Setup
#define RPIN 36
#define GPIN 37
#define BPIN 35

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

// RGB Status Indicator
// Red: Error
// Yellow: Lift Init
// Cyan: Lift Reset
// Green: Ready
RGB rgb(RPIN, GPIN, BPIN);


// NoteHandler setup
const int NOTES = 6;
int midiNotes[NOTES] = {59, 60, 61, 62, 63, 64};
int pos[NOTES - 1] = {500, 600, 700, 800, 900}; // Arm position array does not include open string
int clPos[NOTES] = {0, 500, 500, 500, 500, 500};
NoteHandler armHandler(midiNotes + 1, pos, NOTES - 1);
NoteHandler clamperHandler(midiNotes, clPos, NOTES);
bool isPlaying;

// CLAMPER SETUP
/////////////////
// servo range: 300-1200
// open: 0
// clamper: clamp < 750 < damp
// pmute: 750 < mute

UServo clServo(34);
rampInt clRamp;
int clRampDur = 100; // ramp duration in ms
uint32_t clVal;

UServo pmServo(33);
bool pmuteOn;
uint32_t pmTarget;

// STEPPER SETUP
/////////////////

AccelStepper wheel(AccelStepper::DRIVER, WSTEP, WDIR);
int wPins[] = {WMS0, WMS1, WMS2};
bool wModes[] = {false, true, false};
bool tremOn;

AccelStepper lift(AccelStepper::DRIVER, LSTEP, LDIR);
int lPins[] = {LMS0, LMS1, LMS2};
bool lModes[] = {false, true, false};
bool isInit = true;
bool isReset = false;

// limit switch setup
const int switchPin = 14;
Bounce lSwitch = Bounce(switchPin, 10); // arg#2 is debounce time in ms

void setup()
{
  // RGB init
  rgb.init();
  rgb.set(255, 255, 0);

  // MIDI Setup
  usbMIDI.setHandleNoteOn(talosNoteOn);
  usbMIDI.setHandleNoteOff(talosNoteOff);
  usbMIDI.setHandleControlChange(talosControlChange);

  // init state boolean
  isPlaying = false;

  // servomotors init
  clServo.init();
  clRamp.go(0);
  pmServo.init();
  pmuteOn = false;

  // palm mute target
  pmTarget = (UNIT_ID < 4) ? 300 : 1200;

  // stepper motors init
  initPins(WSLEEP, wPins, wModes);
  wheel.setMaxSpeed(20000);
  wheel.setAcceleration(40000);
  tremOn = false;
  initPins(LSLEEP, lPins, lModes);
  lift.setMaxSpeed(20000);
  lift.setAcceleration(40000);
  pinMode(switchPin, INPUT_PULLUP);
  digitalWrite(LSLEEP, HIGH); // enable lift for init

  // dynamixel init
  Serial1.setTX(1);
  Serial1.setRX(0);
  pinMode(2, OUTPUT);
  Dynamixel.begin(1000000, 2, 4);
  Dynamixel.setAngleLimit(1, 250, 1200);

  // print instructions
  Serial.println("Azure Talos MIDI Integration");
  Serial.println("Input MIDI notes:");
  Serial.println("(59--64)");
  Serial.println("CC Commands:");
  Serial.println("0 - Tremolo picking");
  Serial.println("1 - Palm mute");
}

void loop()
{
  if (!isInit) usbMIDI.read();

  liftReset();
  vel();
  pluck();
  pmute();
  clamp();

  wheel.run();
  lift.run();
}

// FUNCTIONS
///////////////

void initPins(int sleepPin, int msPins[], bool msModes[])
{
  pinMode(sleepPin, OUTPUT);
  pinMode(sleepPin, LOW);

  for (int i = 0; i < 3; i++)
  {
    pinMode(msPins[i], OUTPUT);
    digitalWrite(msPins[i], msModes[i]);
  }
}

void pluck()
{
  if (tremOn) {
    if (isPlaying) {
      wheel.move(40);
    }
  } else {
    if (wheel.distanceToGo() == 0) {
      digitalWrite(WSLEEP, LOW);
    }
  }
}

void vel() {
  if (lift.distanceToGo() == 0 && !isInit) {
    digitalWrite(LSLEEP, LOW);
  }
}

void dynaMove(int target)
{
  Dynamixel.moveSpeed(MX64ID, target, 256);
  //Dynamixel.ledStatus(MX64ID, 1);
}

void playNote(int target, int velocity)
{
  isPlaying = true;

  // clamp note
  if (clRamp.isRunning()) clRamp.go(0);
  clVal = target;
  // lift move
  digitalWrite(LSLEEP, HIGH);
  int liftPos = map(velocity, 0, 127, 0, -800);
  lift.moveTo(liftPos);
  // pluck (or start plucking)
  digitalWrite(WSLEEP, HIGH);
  if (!tremOn) wheel.move(80);
}

void releaseNote(int target)
{
  clVal = target;
  if (isPlaying) clRamp.go(100, clRampDur, LINEAR, ONCEFORWARD);
}

void clamp()
{
  clRamp.update();
  if (clRamp.isFinished()) clRamp.go(0);

  if (clRamp.isRunning()) {
    if(clRamp.getValue() < clRampDur/2) {
      clServo.move(950);
    } else {
      clServo.move(750);
    }
  } else clServo.move(clVal);
}

void pmute()
{
  if (!pmuteOn)
  {
    pmServo.move(0);
  }
  else
  {
    if (isPlaying)
      pmServo.move(pmTarget); // only mute if plucking
  }
}

void liftReset() {
  // init lift stepper
  if (isInit) lift.move(-160);

  // pushButton reset
  if (lSwitch.update()) {
    if (lSwitch.fallingEdge()) {
      isInit = false;
      isReset = true;
      rgb.set(0, 255, 255);

      digitalWrite(LSLEEP, HIGH);
      lift.move(1600);
    }
  }

  // disable after reset
  if (lift.distanceToGo() == 0 && isReset) {
    isReset = false;
    rgb.set(0, 255, 0);
    liftZero();
    digitalWrite(LSLEEP, LOW);
  }
}

// set lift reset position as '0'
void liftZero() {
  lift.setCurrentPosition(0);
  lift.setMaxSpeed(20000);
  lift.setAcceleration(40000);
}

void talosNoteOn(byte channel, byte note, byte velocity)
{
  clamperHandler.applyPos(note, velocity, playNote);
  armHandler.applyPos(note, dynaMove);
}

void talosNoteOff(byte channel, byte note, byte velocity)
{
  releaseNote(velocity);
  if (tremOn) digitalWrite(WSLEEP, LOW);

  isPlaying = false;
}

void talosControlChange(byte channel, byte control, byte value)
{
  if (control == 0)
  {
    tremOn = value > 0;
  }
  else if (control == 1)
  {
    pmuteOn = value > 0;
  }
}
