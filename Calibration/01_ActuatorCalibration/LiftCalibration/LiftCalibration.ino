// Polychord
// AccelSteppers and Microstepping

// Microstepping Table
// | MODE0 | MODE1 | MODE2 | Resolution |
// |=======|=======|=======|============|
// | Low   | Low   | Low   | Full Step  |
// | High  | Low   | Low   | Half Step  |
// | Low   | High  | Low   | 1/4  Step  |
// | High  | High  | Low   | 1/8  Step  |
// | Low   | Low   | High  | 1/16 Step  |
// | High  | Low   | High  | 1/32 Step  |
// | Low   | High  | High  | 1/32 Step  |
// | High  | High  | High  | 1/32 Step  |
// |=======|=======|=======|============|


#include <AccelStepper.h>
#include <Bounce.h>
#include <Metro.h>

// Azure 1.1: Lift
#define DIR 4
#define STEP 5
#define SLEEP 6
#define MS2 7
#define MS1 8
#define MS0 9

const int buttonPin = 14;
Bounce pushButton = Bounce(buttonPin, 10);

AccelStepper stp(AccelStepper::DRIVER, STEP, DIR);
bool modes[] = {false, true, false};
bool isInit = true;


void setup() {
  initPins(modes);

  pinMode(buttonPin, INPUT_PULLUP);

  // init steppers
  stp.setMaxSpeed(20000);
  stp.setAcceleration(40000);
  digitalWrite(SLEEP, HIGH); 

  Serial.begin(9600);
}

void loop() {

  liftReset();

  stp.run();
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

void liftReset() {
  // init stepper
  if(isInit) stp.move(-160);

  // pushButton reset
  if (pushButton.update()) {
    if (pushButton.fallingEdge()) {
      isInit = false;

      Serial.println("On");
      digitalWrite(SLEEP, HIGH);
      stp.move(1600);
    }
  }

  // disable after reset
  if (stp.distanceToGo() == 0 && !isInit) {
    digitalWrite(SLEEP, LOW);
  }
}
