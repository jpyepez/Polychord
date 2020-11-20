

[2, 5, 3, 4, 1, 6] @=> int talosPorts[];

TalosString talos[6];

for(0 => int i; i < talos.size(); i++) {
    talos[i].init(i+1, talosPorts[i]);
    talos[i].setMode(1, 1);
}


.25::second => dur p_len;


// sporkable pluck function
fun void playTalos(int str, int pos, dur len) {
    talos[str].pluck(pos, 80, len);
    len => now;
}


spork ~ chromatic(p_len);

while(second => now);


fun void chromatic(dur len) {

    while(true) {
        talos[5].pluckOn(0, 80, len);
        talos[5].pluckOn(1, 80, len);
        talos[5].pluckOn(2, 80, len);
        talos[5].pluckOn(3, 80, len);
        talos[5].pluck(4, 80, len);

        talos[4].pluckOn(0, 80, len);
        talos[4].pluckOn(1, 80, len);
        talos[4].pluckOn(2, 80, len);
        talos[4].pluckOn(3, 80, len);
        talos[4].pluck(4, 80, len);

        talos[3].pluckOn(0, 80, len);
        talos[3].pluckOn(1, 80, len);
        talos[3].pluckOn(2, 80, len);
        talos[3].pluckOn(3, 80, len);
        talos[3].pluck(4, 80, len);

        talos[2].pluckOn(0, 80, len);
        talos[2].pluckOn(1, 80, len);
        talos[2].pluckOn(2, 80, len);
        talos[2].pluck(3, 80, len);

        talos[1].pluckOn(0, 80, len);
        talos[1].pluckOn(1, 80, len);
        talos[1].pluckOn(2, 80, len);
        talos[1].pluckOn(3, 80, len);
        talos[1].pluck(4, 80, len);

        talos[0].pluckOn(0, 80, len);
        talos[0].pluckOn(1, 80, len);
        talos[0].pluckOn(2, 80, len);
        talos[0].pluckOn(3, 80, len);
        talos[0].pluckOn(4, 80, len);
        talos[0].pluck(5, 80, len);
    }

}