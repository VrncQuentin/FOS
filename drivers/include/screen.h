#ifndef _SCREEN_H_
#define _SCREEN_H_

/**
 * @section scr_const Screen's Constants.
 * @subsection scr_basic General constants.
 */
#define VID_MEMADDR (0xb8000) /*!< Start of the Video Memory*/
#define MAX_ROWS    (25)      /*!< Height. */
#define MAX_COLS    (80)      /*!< Width.*/
#define WOB         (0x0f)    /*!< Attribute: White on Black. */

/**
 * @subsection scr_info Screen drive I/O ports.
 */
#define REG_SCREEN_CTRL (0x3D4)
#define REG_SCREEN_DATA (0x3D5)
#endif /* _SCREEN_H_ */
