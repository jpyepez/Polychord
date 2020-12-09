

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
25 => int baseVel;
60 => int dVel;

// chordscales: 6--1 strings
[3, 3, 2, 0, 1, 0] @=> int c_major[];
[3, 2, 0, 0, 3, 3] @=> int g_major[];
[0, 0, 2, 2, 2, 0] @=> int a_major[];
[2, 0, 0, 2, 3, 2] @=> int d_major[];
[0, 0, 2, 2, 1, 0] @=> int a_minor[];
[0, 2, 2, 0, 0, 0] @=> int e_minor[];
[1, 0, 0, 2, 3, 1] @=> int d_minor[];
[1, 1, 3, 3, 3, 1] @=> int bb_major[];

// probability array
[.075, .5, .15, .15, .15, .15] @=> float chance5[];
[.5, .15, .15, .15, .15, .15] @=> float chance6[];


// for(0 => int i; i<6; i++) {
//     spork ~ playTalos(6-i, g_major[i], 80, second);
//     second => now;
// }
// 
// for(0 => int i; i<6; i++) {
//     spork ~ playTalos(6-i, d_minor[i], 80, second);
//     second => now;
// }
//
// while(second => now);


