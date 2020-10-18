
MidiOut mout;
mout.open(1);

MidiMsg msg;



fun void sendMsg(int data1, int data2, int data3) {
    data1 => msg.data1;
    data2 => msg.data2;
    data3 => msg.data3;
    mout.send(msg);
}

fun void blink(int note, dur len) {
    while(true) {
        sendMsg(0x90, note, 127);
        len => now;
        sendMsg(0x90, note, 0);
        len => now;
    }
}

spork ~ blink(60, 1::second);
spork ~ blink(61, 1.25::second);
spork ~ blink(62, 1.5::second);

while(second => now);