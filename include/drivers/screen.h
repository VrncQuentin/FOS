#ifndef _SCREEN_H_
#define _SCREEN_H_

/**
 * @section scr_const Screen's Constants.
 * @subsection scr_basic General constants.
 */
#define VID_MEMADDR      (0xb8000)             /*!< Start of the Video Memory. */
#define MAX_COLS         (80)                  /*!< Width, aka 'x'.*/
#define MAX_ROWS         (25)                  /*!< Height, aka 'y'. */
#define SCR_SURFACE      (MAX_COLS * MAX_ROWS) /*!< Total cells in the screen. */

#define WOB              (0x0f) /*!< Attribute: White on Black. */

/// SCR_OFFSET calculate the offset from #VID_MEMADDR of the pos {x, y}.
#define SCR_OFFSET(x, y) ((y * MAX_COLS + x) * 2)

/**
 * @subsection scr_info Screen drive I/O ports.
 */
#define REG_SCREEN_CTRL (0x3D4)
#define REG_SCREEN_DATA (0x3D5)


/**
 * @section scr_fct Screen driver's function.
 */
void print_char(char c, char attr, int x, int y);
void print_at(char const *s, int x, int y);
#define print(s) (print_at(s, -1, -1))

fos_offset get_cursor(void);
void set_cursor(fos_offset off);

fos_offset handle_scrolling(fos_offset off);
void clear_screen(void);

#endif /* _SCREEN_H_ */
