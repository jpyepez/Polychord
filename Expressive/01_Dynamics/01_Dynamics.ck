

[2, 5, 3, 4, 1, 6] @=> int talosPorts[];

TalosString talos[6];

for(0 => int i; i < talos.size(); i++) {
    talos[i].init(i+1, talosPorts[i]);
    talos[i].setMode(0, 1);
}


// sporkable pluck function
fun void playTalos(int str, int pos, int vel, dur len) {
    talos[str-1].pluck(pos, vel, len);
}

// for(1 => int i; i < 100; i++) {
//     playTalos(4, 0, i, .25::second);
//     <<< i >>>;
// }

.5::second => dur len;
playTalos(6, 0, 1, len);
playTalos(6, 0, 50, len);
playTalos(6, 0, 100, len);
playTalos(6, 0, 1, len);
playTalos(6, 0, 50, len);
playTalos(6, 0, 100, len);

while(second => now);
