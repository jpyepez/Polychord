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
#define UNIT_ID 2

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
// Arm position array does not include open string
const int NOTES = 8;

// available midi notes
// Standard Eb tuning
// consider using standard E MIDI messages
int midiNotes[6][NOTES] = {
  {63, 64, 65, 66, 67, 68, 69, 70},
  {58, 59, 60, 61, 62, 63, 64, 65},
  {54, 55, 56, 57, 58, 59, 60, 61},
  {49, 50, 51, 52, 53, 54, 55, 56},
  {44, 45, 46, 47, 48, 49, 50, 51},
  {39, 40, 41, 42, 43, 44, 45, 46}
};

// robot arm positions
int pos[6][NOTES - 1] = {
  {350, 460, 550, 620, 680, 730, 780},  // 1st: done
  {325, 420, 495, 562, 640, 685, 740},  // 2nd: done
  {310, 410, 490, 550, 615, 665, 725},  // 3rd: done
  {190, 295, 360, 430, 500, 560, 610},  // 4th: done
  {355, 408, 480, 550, 600, 660, 715},  // 5th: done
  {425, 540, 620, 710, 760, 795, 828}   // 6th: done
};

// clamping force values
int clPos[6][NOTES] = {
  {0, 600, 600, 600, 600, 600, 600, 585},
  {0, 625, 625, 615, 625, 625, 625, 625},
  {0, 625, 625, 625, 625, 625, 625, 625},
  {0, 625, 625, 625, 625, 625, 625, 625},
  {0, 625, 625, 625, 625, 625, 625, 625},
  {0, 650, 650, 635, 625, 625, 550, 550}
};

// damping angle values
int dampVal[6] = {850, 900, 925, 885, 900, 935};

// PID Values
int PGain[6] = {120, 220, 200, 200, 200, 200};
int IGain[6] = {20, 20, 20, 20, 20, 20};
int DGain[6] = {0, 0, 0, 0, 0, 0};

// lift setup
int liftStart[6] = {1600, 1300, 1400, 1350, 1200, 1600};
int liftRange[6] = {600, 500, 500, 400, 500, 500};

NoteHandler armHandler(midiNotes[UNIT_ID - 1] + 1, pos[UNIT_ID - 1], NOTES - 1);
NoteHandler clamperHandler(midiNotes[UNIT_ID - 1], clPos[UNIT_ID - 1], NOTES);

// CLAMPER SETUP
/////////////////
// servo range: 300-1200
// open: 0
// clamper: clamp < 750 < damp
// pmute: 750 < mute

UServo clServo(34);
rampInt clRamp;
int clRampDur = 350;  // ramp duration in ms
rampInt openRamp;
int openRampDur = 100;
uint32_t clVal;


UServo pmServo(33);
uint32_t pmTarget;

// STEPPER SETUP
/////////////////

AccelStepper wheel(AccelStepper::DRIVER, WSTEP, WDIR);
int wPins[] = {WMS0, WMS1, WMS2};
bool wModes[] = {false, true, false};

AccelStepper lift(AccelStepper::DRIVER, LSTEP, LDIR);
int lPins[] = {LMS0, LMS1, LMS2};
bool lModes[] = {false, true, false};

// limit switch setup
const int switchPin = 14;
Bounce lSwitch = Bounce(switchPin, 10); // arg#2 is debounce time in ms

// STATUS/PERFORMANCE MODES
/////////////////

bool isInit = true;
bool isReset = false;
bool isPlaying;

bool tremOn;
bool pmuteOn;
bool ghostOn;
int slideSpeed;


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
  openRamp.go(0);
  pmServo.init();
  pmuteOn = false;
  ghostOn = false;

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
  Dynamixel.setAngleLimit(MX64ID, 150, 1000);
  Dynamixel.setPGain(MX64ID, PGain[UNIT_ID - 1]); // 254
  Dynamixel.setIGain(MX64ID, IGain[UNIT_ID - 1]); // 20
  Dynamixel.setDGain(MX64ID, DGain[UNIT_ID - 1]);
  slideSpeed = 128;

  // print instructions
  Serial.println("Azure Talos MIDI Integration");
  Serial.println("Input MIDI notes:");
  Serial.println("(59--64)");
  Serial.println("CC Commands:");
  Serial.println("0 - Tremolo picking");
  Serial.println("1 - Palm mute");
  Serial.println("2 - Ghost notes");
  Serial.println("3 - Slide speed");

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
  Dynamixel.moveSpeed(MX64ID, target, slideSpeed);
  //Dynamixel.ledStatus(MX64ID, 1);
}

void playNote(int target, int velocity)
{
  isPlaying = true;

  // clamp note
  if (clRamp.isRunning()) clRamp.go(0); // reset ramp on note-on

  if (target == 0) {
    openRamp.go(100, openRampDur, LINEAR, ONCEFORWARD);
  }

  // set target/check ghost mode
  clVal = ghostOn ? dampVal[UNIT_ID - 1] : target;

  // lift move
  digitalWrite(LSLEEP, HIGH);
  int liftPos = map(velocity, 0, 127, 0, -liftRange[UNIT_ID-1]);
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
  if (isInit) {
    clServo.move(750);  // init servo
  } else {
    clRamp.update();
    openRamp.update();

    if (clRamp.isFinished()) clRamp.go(0);

    if (clRamp.isRunning()) {
      clServo.move(dampVal[UNIT_ID - 1]); // mute string
    } else {
      if (openRamp.isRunning()) {
        clServo.move(750);                // open string
      } else {
        clServo.move(clVal);              // clamped notes
      }
    }
  }
}

void pmute()
{
  if (isInit) {
    pmServo.move(750);  // init servo
  } else {
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
      lift.move(liftStart[UNIT_ID-1]);
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
  if (control == 20)
  {
    tremOn = value > 0;
  }
  else if (control == 21)
  {
    pmuteOn = value > 0;
  }
  else if (control == 22)
  {
    ghostOn = value > 0;
  }
  else if (control == 23)
  {
    slideSpeed = constrain(map(value, 0, 127, 1, 1023), 1, 1023);
  }
}
