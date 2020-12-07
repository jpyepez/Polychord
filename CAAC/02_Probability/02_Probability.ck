

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
[1, 1, 3, 3, 3, 1] @=> int bb_major[];

// probability array
[.075, .5, .15, .15, .15, .15] @=> float chance5[];
[.5, .15, .15, .15, .15, .15] @=> float chance6[];


spork ~ playChord(c_major, chance5, .25::qtr, 16);
(16*.25)::qtr => now;
spork ~ playChord(e_minor, chance6, .25::qtr, 16);
(16*.25)::qtr => now;
spork ~ playChord(c_major, chance5, .25::qtr, 16);
(16*.25)::qtr => now;
spork ~ playChord(bb_major, chance5, .25::qtr, 16);
(16*.25)::qtr => now;
spork ~ playChord(a_major, chance5, .25::qtr, 16);
(16*.25)::qtr => now;
spork ~ playChord(g_major, chance6, .25::qtr, 16);
(16*.25)::qtr => now;
spork ~ playChord(c_major, chance5, .25::qtr, 16);
(16*.25)::qtr => now;



while(second => now);


fun void playChord(int chord[], float prob[], dur len, int divs) {
    repeat(divs) {
        for(0 => int i; i < 6; i++) {
            Math.random2f(0., 1.) => float dice;

            if(dice < prob[i]){
                baseVel + (dVel*Math.randomf() $ int) => int vel;
                spork ~ playTalos(6-i, chord[i], vel, 4::qtr);
            } 
        }
        len => now;
    }
    second => now;
}

