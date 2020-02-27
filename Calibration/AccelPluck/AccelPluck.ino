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
#include <Metro.h>

#define SLEEP 2
#define STEP 1
#define DIR 0
#define MS0 5
#define MS1 6
#define MS2 7

AccelStepper stp(AccelStepper::DRIVER, STEP, DIR);

Metro stpMetro = Metro(150);

int target = 80;
uint32_t idx = 0;
boolean isAtTarget = true;

bool modes[] = {true, false, true};

void setup() {
  initPins(modes);

  stp.setMaxSpeed(20000);
  stp.setAcceleration(40000);
}

void loop() {
  // set target every interval
  if (stpMetro.check() == 1) {
    digitalWrite(SLEEP, HIGH);
    stp.move(target);
    isAtTarget = false;
  }
  // disable when at target
  if (stp.distanceToGo() == 0 && !isAtTarget) {
    digitalWrite(SLEEP, LOW);
    isAtTarget = true;
  }

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
