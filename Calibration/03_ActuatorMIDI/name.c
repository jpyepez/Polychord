
// To give your project a unique name, this code must be
// placed into a .c file (its own tab).  It can not be in
// a .cpp file or your main sketch (the .ino file).

#include "usb_names.h"

// Edit these lines to create your own name.  The length must
// match the number of characters in your custom name.

#define MANUFACTURER_NAME   {'T','e','e','n','s','y','3','.','5'}
#define MANUFACTURER_NAME_LEN  9
#define MIDI_NAME   {'A','z','u','r','e',' ','T','a','l','o','s'}
#define MIDI_NAME_LEN  11

// Do not change this part.  This exact format is required by USB.

struct usb_string_descriptor_struct usb_string_manufacturer_name = {
        2 + MANUFACTURER_NAME_LEN * 2,
        3,
        MANUFACTURER_NAME
};

struct usb_string_descriptor_struct usb_string_product_name = {
        2 + MIDI_NAME_LEN * 2,
        3,
        MIDI_NAME
};
