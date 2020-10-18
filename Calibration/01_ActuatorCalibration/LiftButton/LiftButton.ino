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

Metro stpMetro = Metro(500);

int targets[] = {0, 800};
uint32_t idx = 0;
boolean isAtTarget = true;

bool modes[] = {false, true, false};


void setup() {
  initPins(modes);

  pinMode(buttonPin, INPUT_PULLUP);

  stp.setMaxSpeed(20000);
  stp.setAcceleration(40000);

  Serial.begin(9600);
}

void loop() {
  
  if(pushButton.update()) {
    if(pushButton.fallingEdge()) {
      Serial.println("On");
      digitalWrite(SLEEP, HIGH);
      stp.moveTo(targets[idx % 2]);
      idx++;
    }
  }

  if(stp.distanceToGo() == 0) {
    digitalWrite(SLEEP, LOW);
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
