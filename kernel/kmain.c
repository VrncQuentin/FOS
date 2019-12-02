#include "fos_common.h"

typedef enum {
    VGA_CBLACK   = 0,
    VGA_CBLUE    = 1,
    VGA_CGREEN   = 2,
    VGA_CCYAN    = 3,
    VGA_CRED     = 4,
    VGA_CMAGENTA = 5,
    VGA_CBROWN   = 6,
    VGA_CWHITE   = 15,

    VGA_CDGREY    = 8, // Color Dark = CD
    VGA_CLGREY    = 7, // Color Light = CL
    VGA_CLBLUE    = 9,
    VGA_CLGREEN   = 10,
    VGA_CLCYAN    = 11,
    VGA_CLRED     = 12,
    VGA_CLMAGENTA = 13,
    VGA_CLBROWN   = 14,
} vga_color;

#define VIDMEM_ADDR  (0xb8000)
#define TERM_MAX_X   (80)
#define TERM_MAX_Y   (25)
#define OFFSET(x, y) (y * TERM_MAX_X + x)

static uint8_t vga_entry_color(vga_color fg, vga_color bg)
{
    return fg | (bg << 4);
}

static uint16_t vga_entry(unsigned char uc, uint8_t color)
{
    return (uint16_t)uc | ((uint16_t)color << 8);
}

static size_t strlen(char const *str)
{
    char const *end = str;

    for (; *end; end += 1);
    return end - str;
}

typedef struct {
    size_t x;
    size_t y;
    uint16_t *buff;
    uint8_t color;
} terminfo;

static void term_init(terminfo *t)
{
    t->buff = (uint16_t*)VIDMEM_ADDR;
    t->color = vga_entry_color(VGA_CWHITE, VGA_CBLACK);

    for (int y = 0; y != TERM_MAX_Y; y += 1)
        for (int x = 0; x != TERM_MAX_X; x += 1)
            t->buff = vga_entry(' ', t->color);
}

static void term_putc(char c)
{
    
}

static void term_puts(char const *str)
{
    while (*str)
        term_putc(*str++);
}

void kmain(void)
{
    terminfo t = {0};

    term_init(&t);
    term_puts("Hello world!\n");
}
