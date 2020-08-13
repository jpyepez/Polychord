

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

int NoteHandler::lookupPos(int midi)
{
    int *query;
    int idx;

    query = std::find(midiArray, midiArray + arraySize, midi);

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

void NoteHandler::applyPos(int midi, callback cb)
{
    int pos = lookupPos(midi);
    cb(pos);
}
