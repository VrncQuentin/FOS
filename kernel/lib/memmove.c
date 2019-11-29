#include "fos_common_types.h"
#include "kernel/lib.h"

void *memmove(void *dest, void const *src, int sz)
{
    if (sz <= sizeof(int)) return memcpy(dest, src, sz);
    char buf[sz] = {0};
    memcpy(buf, src, sz);

    //to finish.
}
