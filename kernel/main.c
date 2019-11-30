#include "fos_common_types.h"
#define VID_MEMADDR      (0xb8000)             /*!< Start of the Video Memory. */
#define MAX_COLS         (80)                  /*!< Width, aka 'x'.*/
#define MAX_ROWS         (25)                  /*!< Height, aka 'y'. */
#define SCR_SURFACE      (MAX_COLS * MAX_ROWS) /*!< Total cells in the screen. */

#define WOB              (0x0f) /*!< Attribute: White on Black. */

/// SCR_OFFSET calculate the offset from #VID_MEMADDR of the pos {x, y}.
#define SCR_OFFSET(x, y) ((y * MAX_COLS + x) * 2)
#define NEW_LINE(off) (SCR_OFFSET(MAX_COLS - 1, off / (2*MAX_COLS)))
#define REG_SCREEN_CTRL ((uint16_t)0x3D4)
#define REG_SCREEN_DATA ((uint16_t)0x3D5)

/* static uint8_t read8_port(uint16_t port) */
/* { */
/*     uint8_t b = 0; */

/*     __asm__("in %%dx, %%al" : "=a" (b) : "d" (port)); */
/*     return b; */
/* } */

static void write8_port(uint16_t port, uint8_t data)
{
    __asm__("out %%al, %%dx" : : "a" (data), "d" (port));
}

/* static int get_cursor(void) */
/* { */
/*     int off = 0; */

/*     write8_port(REG_SCREEN_CTRL, 14); */
/*     off = read8_port(REG_SCREEN_DATA) << 8; */

/*     write8_port(REG_SCREEN_CTRL, 15); */
/*     off += read8_port(REG_SCREEN_DATA); */

/*     return off * 2; */
/* } */

static void set_cursor(int off)
{
    off /= 2;

    write8_port(REG_SCREEN_CTRL, 14);
    write8_port(REG_SCREEN_DATA, off >> 8);

    write8_port(REG_SCREEN_CTRL, 15);
    write8_port(REG_SCREEN_DATA, (off << 8) >> 8);
}

/* int handle_scrolling(int off) */
/* { */
/*     if (off < (2 * SCR_SURFACE)) return off; */

/*     char *vidmem = (char*)VID_MEMADDR; */
/*     memcpy(vidmem, vidmem + (MAX_COLS * 2), (SCR_SURFACE - MAX_COLS) * 2); */

/*     vidmem += ((SCR_SURFACE - MAX_COLS) * 2); */
/*     for (int i = 0; i != MAX_COLS * 2; i += 1) */
/*         vidmem[i] = 0; */

/*     return off - MAX_COLS * 2; */
/* } */

/* static void printchar(char c, char attr) */
/* { */
/*     char *vidmem = (char*)VID_MEMADDR; */
/*     int offset = get_cursor(); */
    
/*     if (c == '\n') { */
/*         offset = NEW_LINE(offset); */
/*     } else { */
/*         vidmem[offset] = c; */
/*         vidmem[offset+1] = attr; */
/*     } */
/*     /\* offset += 2; *\/ */
/*     /\* offset = handle_scrolling(offset); *\/ */
/*     /\* set_cursor(offset); *\/ */
/* } */

/* static void print(char const *s) */
/* { */
/*     while (*s) { */
/*         printchar(*s++, WOB); */
/*     } */
/* } */

void main(void)
{
    const char *str = "my first kernel";
	char *vidptr = (char*)0xb8000; 	//video mem begins here.
	unsigned int i = 0;
	unsigned int j = 0;

	/* this loops clears the screen
	* there are 25 lines each of 80 columns; each element takes 2 bytes */
	while(j < 80 * 25 * 2) {
		/* blank character */
		vidptr[j] = 0x07;
		/* attribute-byte - light grey on black screen */
		vidptr[j+1] = ' ';
		j = j + 2;
	}

        j = 0;
        set_cursor(j);
	/* this loop writes the string to video memory */
	while(str[i] != '\0') {
		/* the character's ascii */
		/* attribute-byte: give character black bg and light grey fg */
		vidptr[j+1] = str[i];
		++i;
		j = j + 2;
	}
}
