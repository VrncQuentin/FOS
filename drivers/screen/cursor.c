#include "fos_common_types.h"
#include "kernel/llvl_io.h"
#include "drivers/screen.h"

/**
 * @fn fos_offset get_cursor(void)
 * @brief Gets the current pos of the cursor as an offset.
 *
 * @param[out] off Offset of the cursor.
 *
 * The device uses its control reg as an index to select its internal regs.\n
 * Reg 14: High byte of the cursor's offset.\n
 * Reg 15: Low byte of the cursor's offset.\n
 *
 * Since the cursor offset reported by the VGA hardware is the # of char,
 * we multiply it by 2 to get a vidmem cell offset.
 */
fos_offset get_cursor(void)
{
    fos_offset off = 0;

    write8_port(REG_SCREEN_CTRL, 14);
    off = read8_port(REG_SCREEN_DATA) << 8;

    write8_port(REG_SCREEN_CTRL, 15);
    off += read8_port(REG_SCREEN_DATA);

    return off * 2;
}

/**
 * @fn void set_cursor(fos_offset off)
 * @brief Gets the current pos of the cursor as an offset.
 *
 * @param[in] off Desired Offset of the cursor.
 *
 * The device uses its control reg as an index to select its internal regs.\n
 * Reg 14: High byte of the cursor's offset.\n
 * Reg 15: Low byte of the cursor's offset.\n
 *
 * vidmem cell to char: off / 2.
 */
void set_cursor(fos_offset off)
{
    off /= 2;

    write8_port(REG_SCREEN_CTRL, 14);
    write8_port(REG_SCREEN_DATA, off >> 8);

    write8_port(REG_SCREEN_CTRL, 15);
    write8_port(REG_SCREEN_DATA, (off << 8) >> 8);
}
