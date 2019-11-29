#include "fos_common.h"
#include "fos_common_types.h"

/**
 * @fn uint8_t read8_port(uint16_t port)
 * @brief Reads a byte from port.
 *
 * @param[in]  port Port to be read.
 * @param[out] b    Byte read.
 *
 * "=a" (b)   means store 'al' to 'b' when done.
 * "d" (port) means load 'port' into 'edx'.
 */
uint8_t read8_port(uint16_t port)
{
    uint8_t b;

    __asm__("in %%dx, %%al" : "=a" (b) : "d" (port));
    return b;
}

/**
 * @fn uint16_t read16_port(uint16_t port)
 * @brief Reads a word from port.
 *
 * @param[in]  port Port to be read.
 * @param[out] w    Word read.
 *
 * "=a" (w)   means store 'eax' to 'w' when done.
 * "d" (port) means load 'port' into 'edx'.
 */
uint16_t read16_port(uint16_t port)
{
    uint16_t w;

    __asm__("in %%dx, %%ax" : "=a" (w) : "d" (port));
    return w;
}

/**
 * @fn void write8_port(uint16_t port, uint8_t data)
 * @brief Write a byte to port.
 *
 * @param[in] port Port to which we'll write.
 * @param[in] data Data to be written to port.
 *
 * "a" (data) means load 'data' to 'al'.
 * "d" (port) means load 'port' to 'edx'.
 */
void write8_port(uint16_t port, uint8_t data)
{
    __asm__("out %%al, %%dx" : : "a" (data), "d" (port));
}

/**
 * @fn void write16_port(uint16_t port, uint16_t data)
 * @brief Write a byte to port.
 *
 * @param[in] port Port to which we'll write.
 * @param[in] data Data to be written to port.
 *
 * "a" (data) means load 'data' to 'eax'.
 * "d" (port) means load 'port' to 'edx'.
 */
void write16_port(uint16_t port, uint16_t data)
{
    __asm__("out %%ax, %%dx" : : "a" (data), "d" (port));
}
