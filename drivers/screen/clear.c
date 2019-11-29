#include "fos_common_types.h"
#include "drivers/screen.h"

void clear_screen(void)
{
    for (int y = 0; y != MAX_ROWS; y++) {
        for (int x = 0; x != MAX_COLS; x++) {
            print_char(0, WOB, x, y);
        }
    }
    set_cursor(0);
}
