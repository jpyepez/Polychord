

[1, 3, 2, 4, 5, 6] @=> int talosPorts[];

1 => int str_id;

TalosString talos;
talos.init(str_id, talosPorts[str_id-1]);
//talos.printNotes();
talos.setMode(3, 16);

// init counter
0 => int counter;

// spork
// spork ~ chromatic();
// spork ~ major();
// spork ~ minor();
// spork ~ phrygian();
spork ~ lydian();


while(second => now);

fun void chromatic() {
    while(true) {
        talos.pluck(counter, 80, second);

        // increase counter
        1 +=> counter;
        talos.getNumNotes() %=> counter;
    }
}

fun void major() {
    while(true) {
        talos.pluck(0, 80, second);
        talos.pluck(2, 80, second);
        talos.pluck(4, 80, second);
        talos.pluck(5, 80, second);
        talos.pluck(7, 80, second);
    }
}


fun void minor() {
    while(true) {
        talos.pluck(0, 80, second);
        talos.pluck(2, 80, second);
        talos.pluck(3, 80, second);
        talos.pluck(5, 80, second);
        talos.pluck(7, 80, second);
    }
}


fun void phrygian() {
    while(true) {
        talos.pluck(0, 80, second);
        talos.pluck(1, 80, second);
        talos.pluck(3, 80, second);
        talos.pluck(5, 80, second);
        talos.pluck(7, 80, second);
    }
}


fun void lydian() {
    while(true) {
        talos.pluck(0, 80, second);
        talos.pluck(2, 80, second);
        talos.pluck(4, 80, second);
        talos.pluck(6, 80, second);
        talos.pluck(7, 80, second);
    }
}

fun void tune(int start, int pos) {
    talos.pluck(start, 80, 2::second);

    while(true) {
        talos.pluck(pos, 80, 2::second);
    }
}
