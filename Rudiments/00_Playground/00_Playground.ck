
// Talos Ports:
// COM10: 5th
// COM15: 6th
// COM11: 1st
// COM12: 2nd
// COM13: 3rd
// COM14: 4th


[2, 5, 3, 4, 1, 6] @=> int talosPorts[];

4 => int str_id;

TalosString talos;
talos.init(str_id, talosPorts[str_id-1]);
//talos.printNotes();

// init counter
0 => int counter;

// spork
// spork ~ chromatic();
// spork ~ major();
// spork ~ minor();
// spork ~ phrygian();
// spork ~ lydian();


while(second => now) {
    talos.pluck(0, 127, 500::ms);
}




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

