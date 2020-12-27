

[2, 5, 3, 4, 1, 6] @=> int talosPorts[];
// TODO: record COM ports for each

2 => int str_id;
1 => int port;

TalosString talos;
talos.init(str_id, talosPorts[str_id-1]);
//talos.printNotes();

// ghost note mode
// talos.setMode(2, 1);

// init counter
0 => int counter;

// spork
// spork ~ chromatic(second);
// spork ~ major(second);
// spork ~ minor(second);
// spork ~ phrygian(second);
// spork ~ lydian(second);

talos.pluck(5, 80, second);


while(true) {
    talos.pluck(3, 80, second);
    second => now;
}

fun void chromatic(dur len) {
    while(true) {
        talos.pluck(counter, 80, len);

        // increase counter
        1 +=> counter;
        talos.getNumNotes() %=> counter;
    }
}

fun void major(dur len) {
    while(true) {
        talos.pluck(0, 80, len);
        talos.pluck(2, 80, len);
        talos.pluck(4, 80, len);
        talos.pluck(5, 80, len);
        talos.pluck(7, 80, len);
    }
}


fun void minor(dur len) {
    while(true) {
        talos.pluck(0, 80, len);
        talos.pluck(2, 80, len);
        talos.pluck(3, 80, len);
        talos.pluck(5, 80, len);
        talos.pluck(7, 80, len);
    }
}


fun void phrygian(dur len) {
    while(true) {
        talos.pluck(0, 80, len);
        talos.pluck(1, 80, len);
        talos.pluck(3, 80, len);
        talos.pluck(5, 80, len);
        talos.pluck(7, 80, len);
    }
}


fun void lydian(dur len) {
    while(true) {
        talos.pluck(0, 80, len);
        talos.pluck(2, 80, len);
        talos.pluck(4, 80, len);
        talos.pluck(6, 80, len);
        talos.pluck(7, 80, len);
    }
}

