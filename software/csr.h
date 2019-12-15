
#define CSR_MEPC 		0x341
#define CSR_MCAUSE 	0x342
#define CSR_MTVEC		0x305
#define CSR_MIE			0x304
#define CSR_MIP			0x344

/**
 * read a CSR value using csrr psuedo instruction
 * @param addr: address, must be constant since encoded in immediate
 * @returns value in CSR
 */
inline unsigned readCSR (unsigned addr) {
	unsigned result;
	asm("csrr %0, %1" : "=r"(result) : "I"(addr));
	return result;
}

/**
 * write a value to CSR using csrrw instruction
 * @param addr: address, must be constant since encoded in immediate
 * @param val: value to be written, passed in a register
 */
inline void writeCSR (unsigned addr, unsigned val) {
	asm("csrrw x0, %0, %1" : : "I"(addr), "r"(val));
}

/**
 * set certain bits in CSR using csrrs instruction
 * @param addr: address, must be constant
 * @param mask: mask for setting bits
 */
inline void setCSR (unsigned addr, unsigned mask) {
	asm("csrrs x0, %0, %1" : : "I"(addr), "r"(mask));
}

/**
 * clear certain bits in CSR using csrrc instruction
 * @param addr: address, must be constant
 * @param mask: mask for clearring
 */
inline void clrCSR (unsigned addr, unsigned mask) {
	asm("csrrc x0, %0, %1" : : "I"(addr), "r"(mask));
}