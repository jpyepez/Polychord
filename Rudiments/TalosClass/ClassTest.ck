

//<<< mout.name().substring(8) >>>;
// RegEx.match("ATString\\d", mout.name()) => int test;
// <<< "Regex: " + test >>>;

1 => int id;


TalosString talos;
talos.init(id, id);
//talos.printNotes();

// init counter
0 => int counter;

talos.setMode(3, 64);

// spork
//spork ~ chromatic();
spork ~ scale();

while(second => now);

fun void chromatic() {
    while(true) {
        talos.pluck(counter, 80, second);

        // increase counter
        1 +=> counter;
        talos.getNumNotes()-1 %=> counter;
    }
}

fun void scale() {
    while(true) {
        talos.pluck(0, 80, second);
        talos.pluck(2, 80, second);
        talos.pluck(3, 80, second);
        talos.pluck(5, 80, second);
        talos.pluck(7, 80, second);
    }
}
