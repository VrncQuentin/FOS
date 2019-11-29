#include "fos_common_types.h"

void *memcpy(void *dest, void const *src, size_t sz)
{
    char const *cs = (char const *)src;
    char *cd = (char *)dest;

    for (; (uintptr_t)cs & (sizeof(*cd) - 1) && sz; sz -= (sizeof(*cd)))
        *cd++ = *cs++;
    if (!sz)
        return dest;

    int const *is = (int const *)cs;
    int *id = (int *)cd;
    for (; sz >= sizeof(*id); sz -= sizeof(*id))
        *id++ = *is++;

    cs = (char const *)is;
    cd = (char *)id;
    for (; sz; sz -= sizeof(*cd))
        *cd++ = *cs++;
    return dest;
}
