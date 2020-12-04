

[2, 5, 3, 4, 1, 6] @=> int talosPorts[];

TalosString talos[6];

for(0 => int i; i < talos.size(); i++) {
    talos[i].init(i+1, talosPorts[i]);
    talos[i].setMode(0, 1);
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

Event dice;

Math.srandom(184);

fun void roll(Event d) {
    Math.random2(0, 7) => int num;
    playMelody(num);

    while(true) {
        d => now;

        // roll dice and play melody
        Math.random2(0, 7) => num;
        playMelody(num);
    }
}

spork ~ roll(dice);

.2::second => dur q;
2::q => dur h;
4::q => dur w;

70 => int baseVel;

// melody A: A#11
fun void melodyA() {

    spork ~ playTalos(5, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(4, 2, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(3, 2, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(4, 1, getVel(baseVel), w);
    q => now;

    spork ~ playTalos(2, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(1, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(2, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(5, 0, getVel(baseVel), w);
    q => now;

    repeat(3) {
        q => now;
        spork ~ playTalos(4, 2, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(3, 2, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(4, 1, getVel(baseVel), w);
        q => now;

        spork ~ playTalos(2, 0, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(1, 0, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(2, 0, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(5, 0, getVel(baseVel), w);
        q => now;
    }

    dice.broadcast();
    w => now;
}

// melodyB: Am(add2)
fun void melodyB() {
    spork ~ playTalos(5, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(4, 2, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(3, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(2, 1, getVel(baseVel), w);
    q => now;

    spork ~ playTalos(2, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(1, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(2, 1, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(5, 0, getVel(baseVel), w);
    q => now;

    repeat(3) {
        q => now;
        spork ~ playTalos(4, 2, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(3, 0, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(2, 1, getVel(baseVel), w);
        q => now;

        spork ~ playTalos(2, 0, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(1, 0, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(2, 1, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(5, 0, getVel(baseVel), w);
        q => now;
    }

    dice.broadcast();
    w => now;
}


fun void melodyC() {
    spork ~ playTalos(5, 3, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(4, 2, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(3, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(2, 3, getVel(baseVel), w);
    q => now;

    spork ~ playTalos(1, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(2, 1, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(3, 4, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(5, 3, getVel(baseVel), w);
    q => now;

    repeat(3) {
        q => now;
        spork ~ playTalos(4, 2, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(3, 0, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(2, 3, getVel(baseVel), w);
        q => now;

        spork ~ playTalos(1, 0, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(2, 1, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(3, 4, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(5, 3, getVel(baseVel), w);
        q => now;
    }

    dice.broadcast();
    w => now;
}

fun void melodyD() {
    spork ~ playTalos(6, 3, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(4, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(3, 4, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(2, 3, getVel(baseVel), w);
    q => now;

    spork ~ playTalos(1, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(2, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(3, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(6, 3, getVel(baseVel), w);
    q => now;

    repeat(3) {
        q => now;
        spork ~ playTalos(4, 0, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(3, 4, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(2, 3, getVel(baseVel), w);
        q => now;

        spork ~ playTalos(1, 0, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(2, 0, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(3, 0, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(6, 3, getVel(baseVel), w);
        q => now;
    }

    dice.broadcast();
    w => now;
}


fun void melodyE() {
    spork ~ playTalos(6, 1, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(4, 3, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(3, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(2, 1, getVel(baseVel), w);
    q => now;

    spork ~ playTalos(1, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(2, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(3, 2, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(6, 1, getVel(baseVel), w);
    q => now;

    repeat(3) {
        q => now;
        spork ~ playTalos(4, 3, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(3, 0, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(2, 1, getVel(baseVel), w);
        q => now;

        spork ~ playTalos(1, 0, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(2, 0, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(3, 2, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(6, 1, getVel(baseVel), w);
        q => now;
    }

    dice.broadcast();
    w => now;
}


fun void melodyF() {
    spork ~ playTalos(6, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(4, 4, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(3, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(2, 0, getVel(baseVel), w);
    q => now;

    spork ~ playTalos(1, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(2, 3, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(3, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(6, 0, getVel(baseVel), w);
    q => now;

    repeat(3) {
        q => now;
        spork ~ playTalos(4, 4, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(3, 0, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(2, 0, getVel(baseVel), w);
        q => now;

        spork ~ playTalos(1, 0, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(2, 3, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(3, 0, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(6, 0, getVel(baseVel), w);
        q => now;
    }

    dice.broadcast();
    w => now;
}


fun void melodyG() {
    spork ~ playTalos(4, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(3, 2, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(2, 1, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(1, 1, getVel(baseVel), w);
    q => now;

    spork ~ playTalos(1, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(2, 3, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(3, 2, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(4, 0, getVel(baseVel), w);
    q => now;

    repeat(3) {
        q => now;
        spork ~ playTalos(3, 2, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(2, 1, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(1, 1, getVel(baseVel), w);
        q => now;

        spork ~ playTalos(1, 0, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(2, 3, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(3, 2, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(4, 0, getVel(baseVel), w);
        q => now;
    }

    dice.broadcast();
    w => now;
}


fun void melodyH() {
    spork ~ playTalos(6, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(4, 2, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(3, 1, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(2, 0, getVel(baseVel), w);
    q => now;

    spork ~ playTalos(1, 2, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(2, 0, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(3, 1, getVel(baseVel), w);
    q => now;
    spork ~ playTalos(6, 0, getVel(baseVel), w);
    q => now;

    repeat(3) {
        q => now;
        spork ~ playTalos(4, 2, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(3, 1, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(2, 0, getVel(baseVel), w);
        q => now;

        spork ~ playTalos(1, 2, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(2, 0, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(3, 1, getVel(baseVel), w);
        q => now;
        spork ~ playTalos(6, 0, getVel(baseVel), w);
        q => now;
    }

    dice.broadcast();
    w => now;
}


while(second => now);

///////////////
// FUNCTIONS


fun int getVel(int base) {
    return base + Math.random2(0, 20);
}

fun void playMelody(int idx) {
    <<< idx >>>; 

    if(idx == 0) {
        spork ~ melodyA();
    } else if(idx == 1) {
        spork ~ melodyB();
    } else if(idx == 2) {
        spork ~ melodyC();
    } else if(idx == 3) {
        spork ~ melodyD();
    } else if(idx == 4) {
        spork ~ melodyE();
    } else if(idx == 5) {
        spork ~ melodyF();
    } else if(idx == 6) {
        spork ~ melodyG();
    } else {
        spork ~ melodyH();
    }
}
