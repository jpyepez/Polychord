
/*
 * NoteHandler.h - Chordophone note handler
 * Created by JP Yepez, Aug 2020.
 * Victoria University of Wellington
*/

#ifndef NoteHandler_h
#define NoteHandler_h

#include "Arduino.h"

class NoteHandler
{
private:
    int *posArray;
    int *midiArray;
    int arraySize;

public:
    NoteHandler(const int *, const int *, int);

    int getPos(int);
    int lookupPos(int);
};

#endif
