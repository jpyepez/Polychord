

/*
 * NoteHandler.h - Chordophone note handler
 * Created by JP Yepez, Aug 2020.
 * Victoria University of Wellington
*/

#include "Arduino.h"
#include <iostream>
#include <algorithm>
#include "NoteHandler.h"

NoteHandler::NoteHandler(const int *mArray, const int *pArray, int aSize) : arraySize(aSize)
{
    midiArray = new int[arraySize];
    posArray = new int[arraySize];
    std::copy(mArray, mArray + arraySize, midiArray);
    std::copy(pArray, pArray + arraySize, posArray);
}

int NoteHandler::getPos(int idx)
{
    return posArray[idx];
}

// input midi note, return position at same index
int NoteHandler::lookupPos(int midiNote)
{
    int *query;
    int idx;

    query = std::find(midiArray, midiArray + arraySize, midiNote);

    if (query != midiArray + arraySize)
    {
        idx = std::distance(midiArray, query);
        return posArray[idx];
    }
    else
    {
        return -1;
    }
}

typedef void (*callback)(int);
typedef void (*callback2)(int, int);

// look up position and apply callback
void NoteHandler::applyPos(int midiNote, callback cb)
{
    int pos = lookupPos(midiNote);
    if (pos != -1)
        cb(pos);
}

void NoteHandler::applyPos(int midiNote, int velocity, callback2 cb)
{
    int pos = lookupPos(midiNote);
    if (pos != -1)
        cb(pos, velocity);
}
