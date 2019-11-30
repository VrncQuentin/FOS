#include "fos_common_types.h"
#include "kernel/lib.h"
#include "drivers/screen.h"

fos_offset handle_scrolling(fos_offset off)
{
    if (off < (2 * SCR_SURFACE)) return off;

    char *vidmem = (char *)VID_MEMADDR;
    memcpy(vidmem, vidmem + (MAX_COLS * 2), (SCR_SURFACE - MAX_COLS) * 2);

    vidmem += (SCR_SURFACE - MAX_COLS) * 2;
    for (int i = 0; i != MAX_COLS * 2; i += 1)
        vidmem[i] = 0;

    return off - MAX_COLS * 2;
}
