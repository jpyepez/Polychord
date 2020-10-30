

MidiOut mout;
MidiMsg msg;

// open MIDI device
mout.open(1);

// string notes
[   [63, 64, 65, 66, 67, 68, 69, 70, 71], 
    [58, 59, 60, 61, 62, 63, 64, 65, 66], 
    [54, 55, 56, 57, 58, 59, 60, 61, 62], 
    [49, 50, 51, 52, 53, 54, 55, 56, 57], 
    [44, 45, 46, 47, 48, 49, 50, 51, 52], 
    [39, 40, 41, 42, 43, 44, 45, 46, 47]] @=> int notes[][]; 

1 => int string_id; // strings 1--6
0 => int counter;

// initialize performance modes
// tremolo mode: 0
sendMsg(0xB0, 0, 0);

// palm mute: 1
sendMsg(0xB0, 1, 0);

// ghost notes: 2
sendMsg(0xB0, 2, 0);

// slide speed: 3
sendMsg(0xB0, 3, 32);

// spork
spork ~ melody();

while(second => now);

fun void melody() {
    while(true) {
        pluck(notes[string_id-1][counter], 2::second);
        (counter + 1) % notes[string_id-1].size() => counter;
        // (counter + 1) % 6 => counter;
        // 0 => counter;
    }
}

/////////////
// FUNCTIONS

fun void sendMsg(int data1, int data2, int data3) {
    data1 => msg.data1;
    data2 => msg.data2;
    data3 => msg.data3;
    mout.send(msg);
}

fun void pluck(int midiNote, dur len) {
    sendMsg(0x90, midiNote, 80);
    .5::len => now;
    sendMsg(0x80, midiNote, 0);
    .5::len => now;
}
