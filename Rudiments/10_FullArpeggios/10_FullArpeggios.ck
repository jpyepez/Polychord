

[2, 5, 3, 4, 1, 6] @=> int talosPorts[];

TalosString talos[6];

for(0 => int i; i < talos.size(); i++) {
    talos[i].init(i+1, talosPorts[i]);
    talos[i].setMode(1, 0);
}


// sporkable pluck function
fun void playTalos(int str, int pos, dur len) {
    talos[str-1].pluck(pos, 80, len);
}

// chord arrays (str 1--6)
[3, 3, 0, 0, 2, 3] @=> int g_major[];
[0, 1, 0, 2, 3, 3] @=> int c_major[];
[2, 3, 2, 0, 0, 2] @=> int d_major[];
[0, 2, 2, 2, 0, 0] @=> int a_major[];
[0, 0, 1, 2, 2, 0] @=> int e_major[];
[1, 1, 2, 3, 3, 1] @=> int f_major[];
[0, 0, 0, 2, 2, 0] @=> int e_minor[];
[0, 1, 2, 2, 0, 0] @=> int a_minor[];

[ 6, 5, 4, 3, 2, 1,
  6, 5, 4, 3, 2, 1,
  6, 5, 4, 3, 2, 1,
  6, 5, 4, 3, 2, 1 ] @=> int patA[];

[ 6, 3, 2, 3, 1, 2, 3, 2,
  6, 3, 2, 3, 1, 2, 3, 2,
  6, 3, 2, 3, 1, 2, 3, 2,
  6, 3, 2, 3, 1, 2, 3, 2 ] @=> int patB[];

[ 5, 3, 2, 3, 4, 3, 2, 3, 
  5, 3, 2, 3, 4, 3, 2, 3, 
  5, 3, 2, 3, 4, 3, 2, 3, 
  5, 3, 2, 3, 4, 3, 2, 3 ] @=> int patC[];

[ 5, 1, 2, 3, 4, 1, 2, 3,
  5, 1, 2, 3, 4, 1, 2, 3,
  5, 1, 2, 3, 4, 1, 2, 3,
  5, 1, 2, 3, 4, 1, 2, 3 ] @=> int patD[];

// spork ~ progA(.25::second);
// spork ~ progB(.125::second);
// spork ~ progC(.2::second);
spork ~ progD(.1::second);


while(second => now);

// arpeggio function
// MUST spork
fun void playArp(int chord[], int pat[], dur len) {
    for( 0 => int i; i < pat.size(); i++) {
        spork ~ playTalos(pat[i], chord[pat[i]-1], second);
        len => now;
    }
}

fun void playChord(int chord[], dur len) {
    for( 0 => int i; i < chord.size(); i++) {
        spork ~ playTalos(i+1, chord[i], len);
    }
    len => now; // tail for last note
    4::second => now; // tail for last note
}

fun void progA(dur len) {
    patA.size() => int totalDur;

    spork ~ playArp(g_major, patA, len);
    totalDur::len => now;
    spork ~ playArp(d_major, patA, len);
    totalDur::len => now;
    spork ~ playArp(c_major, patA, len);
    totalDur::len => now;
    spork ~ playArp(g_major, patA, len);
    totalDur::len => now;
    playChord(g_major, 4::second);

    4::second => now; // tail for last note
}

fun void progB(dur len) {
    patB.size() => int totalDur;

    spork ~ playArp(e_minor, patB, len);
    totalDur::len => now;
    spork ~ playArp(g_major, patB, len);
    totalDur::len => now;
    spork ~ playArp(e_minor, patB, len);
    totalDur::len => now;
    spork ~ playArp(c_major, patB, len);
    totalDur::len => now;
    spork ~ playArp(a_minor, patB, len);
    totalDur::len => now;
    spork ~ playArp(e_minor, patB, len);
    totalDur::len => now;
    spork ~ playArp(g_major, patB, len);
    totalDur::len => now;
    spork ~ playArp(e_minor, patB, len);
    totalDur::len => now;
    playChord(e_minor, 4::second);

    4::second => now; // tail for last note
}

fun void progC(dur len) {
    patC.size() => int totalDur;

    spork ~ playArp(a_minor, patC, len);
    totalDur::len => now;
    spork ~ playArp(e_minor, patC, len);
    totalDur::len => now;
    spork ~ playArp(f_major, patC, len);
    totalDur::len => now;
    spork ~ playArp(a_minor, patC, len);
    totalDur::len => now;
    playChord(a_minor, 4::second);

    4::second => now; // tail for last note
}

fun void progD(dur len) {
    patD.size() => int totalDur;

    repeat(2) {
        spork ~ playArp(a_major, patD, len);
        totalDur::len => now;
        spork ~ playArp(c_major, patD, len);
        totalDur::len => now;
        spork ~ playArp(f_major, patD, len);
        totalDur::len => now;
        spork ~ playArp(g_major, patD, len);
        totalDur::len => now;
    }

    spork ~ playArp(a_major, patD, len);
    totalDur::len => now;
    spork ~ playArp(a_major, patD, len);
    totalDur::len => now;
    playChord(a_major, 4::second);

    4::second => now; // tail for last note
}