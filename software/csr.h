
#define CSR_MEPC 		0x341
#define CSR_MCAUSE 	0x342
#define CSR_MTVEC		0x305
#define CSR_MIE			0x304
#define CSR_MIP			0x344


inline unsigned readCSR (unsigned addr) {
	unsigned result;
	asm("csrr %0, %1" : "=r"(result) : "I"(addr));
	return result;
}

inline void writeCSR (unsigned addr, unsigned val) {
	asm("csrrw x0, %0, %1" : : "I"(addr), "r"(val));
}

inline void setCSR (unsigned addr, unsigned mask) {
	asm("csrrs x0, %0, %1" : : "I"(addr), "r"(mask));
}

inline void clrCSR (unsigned addr, unsigned mask) {
	asm("csrrc x0, %0, %1" : : "I"(addr), "r"(mask));
}