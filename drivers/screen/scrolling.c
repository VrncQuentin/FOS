#include "fos_common_types.h"
#include "kernel/lib.h"
#include "drivers/screen.h"

fos_offset handle_scrolling(fos_offset off)
{
    if (off < (2 * SCR_SURFACE)) return off;

    char *vidmem = (char *)VID_MEMADDR;
    memcpy(vidmem, vidmem + MAX_COLS, (SCR_SURFACE - MAX_COLS));

    vidmem += SCR_SURFACE - MAX_COLS;
    for (int i = 0; i != MAX_COLS; i += 1)
        vidmem[i] = 0;

    return off - 2 * MAX_COLS;
}
