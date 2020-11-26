

[2, 5, 3, 4, 1, 6] @=> int talosPorts[];

TalosString talos[6];

for(0 => int i; i < talos.size(); i++) {
    talos[i].init(i+1, talosPorts[i]);
    talos[i].setMode(1, 0);
}


.25::second => dur p_len;


// sporkable pluck function
fun void playTalos(int str, int pos, dur len) {
    talos[str-1].pluck(pos, 80, len);
}

spork ~ progA(second);
// spork ~ progB(2::second);
// spork ~ progC(second);


while(second => now);

fun void progA(dur len) {
    spork ~ g_chord(2::len);
    2::len => now;
    spork ~ d_chord(len);
    len => now;
    spork ~ g_chord(len);
    len => now;
    spork ~ c_chord(2::len);
    2::len => now;
    spork ~ g_chord(len);
    len => now;
    spork ~ d_chord(len);
    len => now;
    spork ~ g_chord(2::len);
    2::len => now;

    second => now;  // finish any sporked shreds
}

fun void progB(dur len) {
    spork ~ c_chord(len);
    len => now;
    spork ~ g_chord(len);
    len => now;
    spork ~ am_chord(len);
    len => now;
    spork ~ f_chord(len);
    len => now;
    spork ~ c_chord(len);
    len => now;
    spork ~ g_chord(len);
    len => now;
    spork ~ c_chord(len);
    len => now;
    spork ~ g_chord(len);
    len => now;
    spork ~ c_chord(len);
    len => now;
    
    second => now;  // finish any sporked shreds
}

fun void progC(dur len) {
    repeat(2) {
        spork ~ c_chord(len);
        len => now;
        spork ~ d_chord(len);
        len => now;
        spork ~ em_chord(2::len);
        2::len => now;
    }

    spork ~ g_chord(2::len);
    2::len => now;
    spork ~ d_chord(2::len);
    2::len => now;
    spork ~ em_chord(4::len);
    4::len => now;

    second => now;
}

fun void g_chord(dur len) {
    spork ~ playTalos(6, 3, len);
    spork ~ playTalos(5, 2, len);
    spork ~ playTalos(4, 0, len);
    spork ~ playTalos(3, 0, len);
    spork ~ playTalos(2, 3, len);
    spork ~ playTalos(1, 3, len);
    2::len => now;
}

fun void c_chord(dur len) {
    spork ~ playTalos(5, 3, len);
    spork ~ playTalos(4, 2, len);
    spork ~ playTalos(3, 0, len);
    spork ~ playTalos(2, 1, len);
    spork ~ playTalos(1, 0, len);
    2::len => now;
}

fun void d_chord(dur len) {
    spork ~ playTalos(4, 0, len);
    spork ~ playTalos(3, 2, len);
    spork ~ playTalos(2, 3, len);
    spork ~ playTalos(1, 2, len);
    2::len => now;
}

fun void f_chord(dur len) {
    spork ~ playTalos(6, 1, len);
    spork ~ playTalos(5, 3, len);
    spork ~ playTalos(4, 3, len);
    spork ~ playTalos(3, 2, len);
    spork ~ playTalos(2, 1, len);
    spork ~ playTalos(1, 1, len);
    2::len => now;
}

fun void em_chord(dur len) {
    spork ~ playTalos(6, 0, len);
    spork ~ playTalos(5, 2, len);
    spork ~ playTalos(4, 2, len);
    spork ~ playTalos(3, 0, len);
    spork ~ playTalos(2, 0, len);
    spork ~ playTalos(1, 0, len);
    2::len => now;
}

fun void am_chord(dur len) {
    spork ~ playTalos(5, 0, len);
    spork ~ playTalos(4, 2, len);
    spork ~ playTalos(3, 2, len);
    spork ~ playTalos(2, 1, len);
    spork ~ playTalos(1, 0, len);
    2::len => now;
}