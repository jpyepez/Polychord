

[2, 5, 3, 4, 1, 6] @=> int talosPorts[];

TalosString talos[3];

for(0 => int i; i < talos.size(); i++) {
    talos[i].init(i+1, talosPorts[i]);
}

// spork ~ chromatic(.5::second);
// spork ~ major(.5::second);
// spork ~ minor(.5::second);
// spork ~ harmonic_minor(.5::second);

while(second => now);

fun void chromatic(dur len) {
    while(true) {
        talos[2].pluck(0, 80, len);
        talos[2].pluck(1, 80, len);
        talos[2].pluck(2, 80, len);
        talos[2].pluck(3, 80, len);
        talos[1].pluck(0, 80, len);
        talos[1].pluck(1, 80, len);
        talos[1].pluck(2, 80, len);
        talos[1].pluck(3, 80, len);
        talos[1].pluck(4, 80, len);
        talos[0].pluck(0, 80, len);
        talos[0].pluck(1, 80, len);
        talos[0].pluck(2, 80, len);
        talos[0].pluck(3, 80, len);
        talos[0].pluck(4, 80, len);
        talos[0].pluck(5, 80, len);
    }
}

fun void major(dur len) {
    while(true) {
        talos[2].pluck(0, 80, len);
        talos[2].pluck(2, 80, len);
        talos[1].pluck(0, 80, len);
        talos[1].pluck(1, 80, len);
        talos[1].pluck(3, 80, len);
        talos[0].pluck(0, 80, len);
        talos[0].pluck(2, 80, len);
        talos[0].pluck(3, 80, len);
    }
}

fun void minor(dur len) {
    while(true) {
        talos[2].pluck(0, 80, len);
        talos[2].pluck(2, 80, len);
        talos[2].pluck(3, 80, len);
        talos[1].pluck(1, 80, len);
        talos[1].pluck(3, 80, len);
        talos[1].pluck(4, 80, len);
        talos[0].pluck(1, 80, len);
        talos[0].pluck(3, 80, len);
    }
}


fun void harmonic_minor(dur len) {
    while(true) {
        talos[2].pluck(0, 80, len);
        talos[2].pluck(2, 80, len);
        talos[2].pluck(3, 80, len);
        talos[1].pluck(1, 80, len);
        talos[1].pluck(3, 80, len);
        talos[1].pluck(4, 80, len);
        talos[0].pluck(2, 80, len);
        talos[0].pluck(3, 80, len);
    }
}
