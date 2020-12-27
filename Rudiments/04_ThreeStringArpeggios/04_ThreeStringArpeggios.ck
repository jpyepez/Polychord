

[2, 5, 3, 4, 1, 6] @=> int talosPorts[];

TalosString talos[3];

for(0 => int i; i < talos.size(); i++) {
    talos[i].init(i+1, talosPorts[i]);
}

spork ~ chords1(.5::second);

while(second => now);

fun void c_chord(dur len) {
    talos[0].pluck(0, 80, len);
    talos[1].pluck(1, 80, len);
    talos[2].pluck(0, 80, len);
}

fun void g_chord(dur len) {
    talos[0].pluck(3, 80, len);
    talos[1].pluck(0, 80, len);
    talos[2].pluck(0, 80, len);
}

fun void d_chord(dur len) {
    talos[0].pluck(2, 80, len);
    talos[1].pluck(3, 80, len);
    talos[2].pluck(2, 80, len);
}

fun void chords1(dur len) {
    repeat(2) {
        g_chord(len);
        c_chord(len);
        d_chord(len);
        c_chord(len);
    }
    g_chord(len);
}


fun void clear(dur len) {
    talos[0].pluck(0, 80, len);
    talos[1].pluck(0, 80, len);
    talos[2].pluck(0, 80, len);
}
