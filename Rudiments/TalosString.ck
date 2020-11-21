// TalosString Class
// Connect and control Azure Talos in ChucK


public class TalosString {

    MidiOut mout;
    MidiMsg msg;

    1 => int id; // init as 1 by default

    // string notes
    // standard Eb tuning
    [   [63, 64, 65, 66, 67, 68, 69, 70], 
        [58, 59, 60, 61, 62, 63, 64, 65], 
        [54, 55, 56, 57, 58, 59, 60, 61], 
        [49, 50, 51, 52, 53, 54, 55, 56], 
        [44, 45, 46, 47, 48, 49, 50, 51], 
        [39, 40, 41, 42, 43, 44, 45, 46]] @=> int notes[][]; 

    // initialize class
    fun void init(int string_id, int midi_port) {
        string_id => id;
        mout.open(midi_port);

        initModes();
    }
    
    fun void initModes() {

        // initialize performance modes
        // tremolo mode: 0
        setMode(0, 0);

        // palm mute: 1
        setMode(1, 0);

        // ghost notes: 2
        setMode(2, 0);

        // slide speed: 3
        setMode(3, 16);
    }


    // NOTE DATA
    /////////////

    // utility: print notes
    fun void printNotes() {
        string arrNotes;

        for(0 => int i; i < notes[id-1].size(); i++) {
            Std.itoa(notes[id-1][i]) +=> arrNotes;
            if(i != (notes[id-1].size()-1)) 
                ", " +=> arrNotes;
        }

        <<< "\nString: " + id + "\n" + "Notes: " + arrNotes + "\n\n">>>;
    }

    // get note at string position
    fun  int getNote(int pos) {
        return notes[id-1][pos];
    }

    // get number of available notes (note array size)
    fun int getNumNotes() {
        return notes[id-1].size();
    }

    // MIDI
    ///////////

    fun void sendMsg(int data1, int data2, int data3) {
        data1 => msg.data1;
        data2 => msg.data2;
        data3 => msg.data3;
        mout.send(msg);
    }


    fun void pluck(int pos, int vel, dur len) {
        sendMsg(0x90, notes[id-1][pos], vel);
        len => now;
        sendMsg(0x80, notes[id-1][pos], 0);
    }

    fun void setMode(int data, int value) {
        sendMsg(0xB0, data, value);
    }
}