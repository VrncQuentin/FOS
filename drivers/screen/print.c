#include "fos_common_types.h"
#include "kernel/llvl_io.h"
#include "drivers/screen.h"

/**
 * @fn void print_char(char c, char attr, int col, int row)
 * @brief Print a char to the screen.
 */
void print_char(char c, char attr, int x, int y)
{
    if (!attr) attr = WOB;
    char *vidmem = (char *)VID_MEMADDR;
    fos_offset offset;

    if (x >= 0 && y >= 0) {
        offset = SCR_OFFSET(x, y);
    } else {
        offset = get_cursor();
    }

    if (c == '\n') {
        offset = SCR_OFFSET(MAX_COLS - 1, offset / (2*MAX_COLS));
    } else {
        vidmem[offset] = c;
        vidmem[offset+1] = attr;
    }

    offset += 2;
    offset = handle_scrolling(offset);
    set_cursor(offset);
}

void print_at(char const *s, int x, int y)
{
    if (x >= 0 && y >= 0) {
        set_cursor(SCR_OFFSET(x, y));
    }

    while (*s) {
        print_char(*s++, WOB, x, y);
    }
}
