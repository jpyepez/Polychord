

[2, 5, 3, 4, 1, 6] @=> int talosPorts[];

TalosString talos[6];

for(0 => int i; i < talos.size(); i++) {
    talos[i].init(i+1, talosPorts[i]);
    talos[i].setMode(21, 0);
}


// sporkable pluck function
fun void playTalos(int str, int pos, int vel, dur len) {
    talos[str-1].pluck(pos, vel, len);
}

// for(1 => int i; i < 100; i++) {
//     playTalos(4, 0, i, .25::second);
//     <<< i >>>;
// }

//////////////////////////////


Math.srandom(126);



40 => int x;

// consider timed rather than x times
fun void playLow(int reps, dur off) {
    // duration setup
    .5::second + off => dur qtr;

    repeat(reps) {
        playTalos(6, 0, getVel(30, 20), qtr);
        playTalos(6, 2, getVel(30, 20), qtr);
        playTalos(6, 3, getVel(30, 20), qtr);
        playTalos(6, 0, getVel(30, 20), qtr);
        playTalos(6, 2, getVel(30, 20), qtr);
        playTalos(6, 3, getVel(30, 20), qtr);
        playTalos(5, 0, getVel(30, 20), qtr);
        playTalos(6, 3, getVel(30, 20), qtr);
    }
}


fun void playMid(int reps, dur off) {
    // duration setup
    .5::second + off => dur qtr;

    repeat(reps) {
        playTalos(4, 2, getVel(40, 20), qtr);
        playTalos(4, 4, getVel(40, 20), qtr);
        playTalos(3, 0, getVel(40, 20), qtr);
        playTalos(4, 2, getVel(40, 20), qtr);
        playTalos(4, 4, getVel(40, 20), qtr);
        playTalos(3, 0, getVel(40, 20), qtr);
        playTalos(3, 2, getVel(40, 20), qtr);
        playTalos(3, 0, getVel(40, 20), qtr);
    }
}

fun void playHigh(int reps, dur off) {
    // duration setup
    .5::second + off => dur qtr;

    repeat(reps) {
        playTalos(1, 0, getVel(80, 20), qtr);
        playTalos(1, 2, getVel(80, 20), qtr);
        playTalos(1, 3, getVel(80, 20), qtr);
        playTalos(1, 0, getVel(80, 20), qtr);
        playTalos(1, 2, getVel(80, 20), qtr);
        playTalos(1, 3, getVel(80, 20), qtr);
        playTalos(2, 1, getVel(80, 20), qtr);
        playTalos(1, 3, getVel(80, 20), qtr);
    }
}


spork ~ playLow(x, 0::ms);
spork ~ playMid(x, 2::ms);
spork ~ playHigh(x, 2::ms);

while(second => now);

fun int getVel(int baseVel, int dVel) {
    return baseVel + Math.random2(-dVel, dVel);
}

