

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


// spork ~ chromatic(p_len);
// spork ~ c_major(p_len);
// spork ~ g_major(p_len);
// spork ~ f_major(p_len);
// spork ~ e_minor(p_len);
spork ~ a_minor(p_len);


while(second => now);


fun void chromatic(dur len) {

    while(true) {
        talos[5].pluck(0, 80, len);
        talos[5].pluck(1, 80, len);
        talos[5].pluck(2, 80, len);
        talos[5].pluck(3, 80, len);
        talos[5].pluck(4, 80, len);

        talos[4].pluck(0, 80, len);
        talos[4].pluck(1, 80, len);
        talos[4].pluck(2, 80, len);
        talos[4].pluck(3, 80, len);
        talos[4].pluck(4, 80, len);

        talos[3].pluck(0, 80, len);
        talos[3].pluck(1, 80, len);
        talos[3].pluck(2, 80, len);
        talos[3].pluck(3, 80, len);
        talos[3].pluck(4, 80, len);

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

fun void c_major(dur len) {
    while(true) {
        talos[4].pluck(3, 80, len);
        talos[3].pluck(0, 80, len);
        talos[3].pluck(2, 80, len);
        talos[3].pluck(3, 80, len);
        talos[2].pluck(0, 80, len);
        talos[2].pluck(2, 80, len);
        talos[1].pluck(0, 80, len);
        talos[1].pluck(1, 80, len);
        talos[1].pluck(0, 80, len);
        talos[2].pluck(2, 80, len);
        talos[2].pluck(0, 80, len);
        talos[3].pluck(3, 80, len);
        talos[3].pluck(2, 80, len);
        talos[3].pluck(0, 80, len);
        talos[4].pluck(3, 80, 2::len);
    }
}

fun void g_major(dur len) {
    while(true) {
        talos[5].pluck(3, 80, len);
        talos[4].pluck(0, 80, len);
        talos[4].pluck(2, 80, len);
        talos[4].pluck(3, 80, len);
        talos[3].pluck(0, 80, len);
        talos[3].pluck(2, 80, len);
        talos[3].pluck(4, 80, len);
        talos[2].pluck(0, 80, len);
        talos[2].pluck(2, 80, len);
        talos[1].pluck(0, 80, len);
        talos[1].pluck(1, 80, len);
        talos[1].pluck(3, 80, len);
        talos[0].pluck(0, 80, len);
        talos[0].pluck(2, 80, len);
        talos[0].pluck(3, 80, len);
        talos[0].pluck(2, 80, len);
        talos[0].pluck(0, 80, len);
        talos[1].pluck(3, 80, len);
        talos[1].pluck(1, 80, len);
        talos[1].pluck(0, 80, len);
        talos[2].pluck(2, 80, len);
        talos[2].pluck(0, 80, len);
        talos[3].pluck(4, 80, len);
        talos[3].pluck(2, 80, len);
        talos[3].pluck(0, 80, len);
        talos[4].pluck(3, 80, len);
        talos[4].pluck(2, 80, len);
        talos[4].pluck(0, 80, len);
        talos[5].pluck(3, 80, 2::len);
    }
}

fun void f_major(dur len) {
    while(true) {
        talos[5].pluck(1, 80, len);
        talos[5].pluck(3, 80, len);
        talos[4].pluck(0, 80, len);
        talos[4].pluck(1, 80, len);
        talos[4].pluck(3, 80, len);
        talos[3].pluck(0, 80, len);
        talos[3].pluck(2, 80, len);
        talos[3].pluck(3, 80, len);
        talos[2].pluck(0, 80, len);
        talos[2].pluck(2, 80, len);
        talos[2].pluck(3, 80, len);
        talos[1].pluck(1, 80, len);
        talos[1].pluck(3, 80, len);
        talos[0].pluck(0, 80, len);
        talos[0].pluck(1, 80, len);
        talos[0].pluck(0, 80, len);
        talos[1].pluck(3, 80, len);
        talos[1].pluck(1, 80, len);
        talos[2].pluck(3, 80, len);
        talos[2].pluck(2, 80, len);
        talos[2].pluck(0, 80, len);
        talos[3].pluck(3, 80, len);
        talos[3].pluck(2, 80, len);
        talos[3].pluck(0, 80, len);
        talos[4].pluck(3, 80, len);
        talos[4].pluck(1, 80, len);
        talos[4].pluck(0, 80, len);
        talos[5].pluck(3, 80, len);
        talos[5].pluck(1, 80, len);
    }
}

// use playTalos to address using string number
fun void e_minor(dur len) {
    while(true) { 
        playTalos(6, 0, len);
        playTalos(6, 2, len);
        playTalos(6, 3, len);
        playTalos(5, 0, len);
        playTalos(5, 2, len);
        playTalos(5, 3, len);
        playTalos(4, 0, len);
        playTalos(4, 2, len);
        playTalos(4, 3, len);
        playTalos(3, 0, len);
        playTalos(3, 2, len);
        playTalos(2, 0, len);
        playTalos(2, 1, len);
        playTalos(2, 3, len);
        playTalos(1, 0, len);

        playTalos(2, 3, len);
        playTalos(2, 1, len);
        playTalos(2, 0, len);
        playTalos(3, 2, len);
        playTalos(3, 0, len);
        playTalos(4, 3, len);
        playTalos(4, 2, len);
        playTalos(4, 0, len);
        playTalos(5, 3, len);
        playTalos(5, 2, len);
        playTalos(5, 0, len);
        playTalos(6, 3, len);
        playTalos(6, 2, len);
        playTalos(6, 0, len);
    }
}

fun void a_minor(dur len) {
    while(true) {
        playTalos(5, 0, len);
        playTalos(5, 2, len);
        playTalos(5, 3, len);
        playTalos(4, 0, len);
        playTalos(4, 2, len);
        playTalos(4, 3, len);
        playTalos(3, 0, len);
        playTalos(3, 2, len);
        playTalos(2, 0, len);
        playTalos(2, 1, len);
        playTalos(2, 3, len);
        playTalos(1, 0, len);
        playTalos(1, 1, len);
        playTalos(1, 3, len);
        playTalos(1, 5, len);
        playTalos(1, 3, len);
        playTalos(1, 1, len);
        playTalos(1, 0, len);
        playTalos(2, 3, len);
        playTalos(2, 1, len);
        playTalos(2, 0, len);
        playTalos(3, 2, len);
        playTalos(3, 0, len);
        playTalos(4, 3, len);
        playTalos(4, 2, len);
        playTalos(4, 0, len);
        playTalos(5, 3, len);
        playTalos(5, 2, len);
        playTalos(5, 0, len);
    }
}