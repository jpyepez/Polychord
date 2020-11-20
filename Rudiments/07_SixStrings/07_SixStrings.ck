

[2, 5, 3, 4, 1, 6] @=> int talosPorts[];

TalosString talos[6];

for(0 => int i; i < talos.size(); i++) {
    talos[i].init(i+1, talosPorts[i]);
    talos[i].setMode(0, 0);
}


.25::second => dur p_len;



while(true) {
    repeat(4) {
        spork ~ playTalos(5, 0, 3::p_len);
        p_len => now;
        spork ~ playTalos(4, 2, 3::p_len);
        p_len => now;
        spork ~ playTalos(3, 2, 3::p_len);
        p_len => now;
        spork ~ playTalos(2, 0, 3::p_len);
        p_len => now;
        spork ~ playTalos(1, 0, 3::p_len);
        p_len => now;
        spork ~ playTalos(0, 0, 3::p_len);
        p_len => now;
    }

    repeat(4) {
        spork ~ playTalos(5, 2, 3::p_len);
        p_len => now;
        spork ~ playTalos(4, 0, 3::p_len);
        p_len => now;
        spork ~ playTalos(3, 0, 3::p_len);
        p_len => now;
        spork ~ playTalos(2, 2, 3::p_len);
        p_len => now;
        spork ~ playTalos(1, 3, 3::p_len);
        p_len => now;
        spork ~ playTalos(0, 2, 3::p_len);
        p_len => now;
    }

    repeat(4) {
        spork ~ playTalos(5, 0, 3::p_len);
        p_len => now;
        spork ~ playTalos(4, 3, 3::p_len);
        p_len => now;
        spork ~ playTalos(3, 3, 3::p_len);
        p_len => now;
        spork ~ playTalos(2, 0, 3::p_len);
        p_len => now;
        spork ~ playTalos(1, 1, 3::p_len);
        p_len => now;
        spork ~ playTalos(0, 0, 3::p_len);
        p_len => now;
    }


}

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
