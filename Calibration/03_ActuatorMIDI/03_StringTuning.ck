

MidiOut mout;
MidiMsg msg;

// open MIDI device
mout.open(1);

// initialize performance modes
// tremolo mode: 0
sendMsg(0xB0, 0, 0);

// palm mute: 1
sendMsg(0xB0, 1, 0);

// spork
spork ~ melody();

while(second => now);

fun void melody() {
    while(true) {
        pluck(63, 2::second);
        pluck(64, 2::second);
        pluck(65, 2::second);
        pluck(66, 2::second);
        pluck(67, 2::second);
        pluck(68, 2::second);
        pluck(69, 2::second);
        pluck(70, 2::second);
        pluck(71, 2::second);
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
    sendMsg(0x90, midiNote, 100);
    .5::len => now;
    sendMsg(0x80, midiNote, 0);
    .5::len => now;
}
