#include "internal.h"

void main(void)
{
    char *vm = (char*)VIDEO_MEM;

    *vm = 'X';
}
