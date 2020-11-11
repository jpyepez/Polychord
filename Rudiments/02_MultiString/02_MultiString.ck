

[1, 3, 2, 4, 5, 6] @=> int talosPorts[];

TalosString talos[3];

for(0 => int i; i < talos.size(); i++) {
    talos[i].init(i+1, talosPorts[i]);
}

.5::second => dur len;

//while(second => now);
while(true) {
    for(0 => int i; i < 4; i++) {
        talos[0].pluck(0, 80, len);
        talos[1].pluck(0, 80, len);
        talos[2].pluck(0, 80, len);
    }

    for(0 => int i; i < 4; i++) {
        talos[0].pluck(2, 80, len);
        talos[1].pluck(3, 80, len);
        talos[2].pluck(2, 80, len);
    }

}
