#ifndef _FOS_KRN_LLVL_IO_H_
#define _FOS_KRN_LLVL_IO_H_

uint8_t read8_port(uint16_t port);
uint16_t read16_port(uint16_t port);

void write8_port(uint16_t port, uint8_t data);
void write16_port(uint16_t port, uint16_t data);

#endif /* _LLVL_IO_H_ */
