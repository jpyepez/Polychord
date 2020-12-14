

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


Math.srandom(134);

// rhythm setup
second => dur qtr;

// velocity setup
30 => int baseVel;
10 => int dVel;

// chordscales: 6--1 strings
[3, 3, 2, 0, 1, 0] @=> int c_major[];
[3, 2, 0, 0, 3, 3] @=> int g_major[];
[0, 0, 2, 2, 2, 0] @=> int a_major[];
[2, 0, 0, 2, 3, 2] @=> int d_major[];
[0, 0, 2, 2, 1, 0] @=> int a_minor[];
[0, 2, 2, 0, 0, 0] @=> int e_minor[];
[0, 2, 2, 0, 3, 2] @=> int e_m_add2[];
[1, 0, 0, 2, 3, 1] @=> int d_minor[];
[1, 1, 3, 3, 3, 1] @=> int bb_major[];

// probability array
[0., 0., 0., .25, .25, .25] @=> float chanceA[];
[0., 0., 0., .35, .25, .45] @=> float chanceB[];
[0., 0., 0., .25, .25, .85] @=> float chanceC[];


// composition
chordSection(e_minor, 6, chanceB);
chordSection(d_major, 6, chanceB);
chordSection(g_major, 6, chanceB);
chordSection(c_major, 6, chanceB);
chordSection(e_m_add2, 6, chanceB);
chordSection(a_minor, 5, chanceB);
chordSection(g_major, 6, chanceB);
chordSection(c_major, 6, chanceB);
chordSection(e_m_add2, 6, chanceB);


while(second => now);


fun void playBass(int chord[], int str) {
    for(0 => int i; i < 8; i++) {
        spork ~ playTalos(str, chord[6-str], 50, second);
        qtr => now;
    }
    second => now;
}

fun void playProb(int chord[], int str, float prob[]) {
    float dice;
    for(0 => int i; i < 32; i++) {
        Math.random2f(0., 1) => dice;
        Math.random2(-dVel, dVel) => int velOff;
        if(dice < prob[6-str]) {
            spork ~ playTalos(str, chord[6-str], 30+velOff, 4::qtr);
        }
        .25::qtr => now;
    }
    4::qtr => now;
}

fun void chordSection(int chord[], int bassString, float prob[]) {
    spork ~ playBass(chord, bassString);
    for(1 => int i; i < 4; i++) {
        spork ~ playProb(chord, i, prob);
    }
    8::qtr => now;
}


