

MidiOut mout[6];
MidiMsg msg;

// open MIDI devices
for(0 => int i; i < mout.size(); i++) {
    mout[i].open(1+i);
}

// initialize performance modes
for(0 => int i; i < mout.size(); i++) {
    // tremolo mode: 0
    sendMsg(mout[i], 0xB0, 0, 1);

    // palm mute: 1
    sendMsg(mout[i], 0xB0, 1, 1);
}

// spork to different devices
spork ~ melody(0);
.5::second => now;
spork ~ melody(1);

while(second => now);

fun void melody(int id) {
    while(true) {
        pluck(mout[id], 59, second);
        pluck(mout[id], 60, second);
        pluck(mout[id], 61, second);
        pluck(mout[id], 62, second);
    }
}

/////////////
// FUNCTIONS

fun void sendMsg(MidiOut mout, int data1, int data2, int data3) {
    data1 => msg.data1;
    data2 => msg.data2;
    data3 => msg.data3;
    mout.send(msg);
}

fun void pluck(MidiOut mout, int midiNote, dur len) {
    sendMsg(mout, 0x90, midiNote, 127);
    .5::len => now;
    sendMsg(mout, 0x80, midiNote, 0);
    .5::len => now;
}
