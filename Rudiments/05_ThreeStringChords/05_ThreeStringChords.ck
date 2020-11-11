

[1, 3, 2, 4, 5, 6] @=> int talosPorts[];

TalosString talos[3];

for(0 => int i; i < talos.size(); i++) {
    talos[i].init(i+1, talosPorts[i]);
}

spork ~ chords1(second);

while(second => now);

// sporkable pluck function
fun void playTalos(int str, int pos, dur len) {
    talos[str].pluck(pos, 80, len);
    len => now;
}

fun void c_chord(dur len) {
    spork ~ playTalos(0, 0, len);
    spork ~ playTalos(1, 1, len);
    spork ~ playTalos(2, 0, len);
    len => now;
}

fun void g_chord(dur len) {
    spork ~ playTalos(0, 3, len);
    spork ~ playTalos(1, 0, len);
    spork ~ playTalos(2, 0, len);
    len => now;
}

fun void d_chord(dur len) {
    spork ~ playTalos(0, 2, len);
    spork ~ playTalos(1, 3, len);
    spork ~ playTalos(2, 2, len);
    len => now;
}


fun void clear(dur len) {
    spork ~ playTalos(0, 0, len);
    spork ~ playTalos(1, 0, len);
    spork ~ playTalos(2, 0, len);
    len => now;
}

fun void chords1(dur len) {
    repeat(2) {
        g_chord(len);
        d_chord(len);
        g_chord(len);
        c_chord(len);
    }
    
    g_chord(len);
    2::second => now;
    clear(second);
    second => now;
}
