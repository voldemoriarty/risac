#include "io.h"
#include "csr.h"

/**
 * Convert an integer to hexadecimal string
 * buff must have atleast 8 bytes
 * @param buff:	buffer to store the ascii characters
 * @param num:	32bit number to convert
 */
static void _itoa (char *buff, int num) {
	union {
		char 	bytes[4];
		int 	word;
	} number;

	number.word = num;
	const char lut[] = "0123456789abcdef";

	// first char is msn of msb
	buff[0] = lut [number.bytes[3] >> 4];
	buff[1] = lut [number.bytes[3] & 0xf];

	buff[2] = lut [number.bytes[2] >> 4];
	buff[3] = lut [number.bytes[2] & 0xf];

	buff[4] = lut [number.bytes[1] >> 4];
	buff[5] = lut [number.bytes[1] & 0xf];

	buff[6] = lut [number.bytes[0] >> 4];
	buff[7] = lut [number.bytes[0] & 0xf];
}

/**
 * Prints a 32bit number in hexadecimal in the 0xnumber format
 * @param uart:	address of Altera JTAG UART IP
 * @param num:	32bit number
 */

static void putnum32(volatile char* uart, int num) {
	char buffer[8];
	_itoa(buffer, num);
	_puts(uart, "0x", 2);
	_puts(uart, buffer, 8);
}

// the (fake) entry point
int main () {
	volatile char *leds = (volatile char *)0x2000000;
	*leds = 0x50;
	volatile char *uart = (volatile char *)0x1000000;
	// for (int i = -1; i < 10; ++i) {
	// 	putnum32(uart, i);
	// 	_puts(uart, "\r\n", 2);
	// }
	// // loopback uart 
	// while (1) {
	// 	// if read data is available, write it for loopback
	// 	volatile unsigned *data = (volatile unsigned *)uart;
	// 	unsigned d = data[0];
	// 	if (d & (1 << 15)) {
	// 		_puts(uart, (char*)&d, 1);
	// 		*leds = *(char*)&d;
	// 	}
	// }
	_puts(uart, "MTVEC: ", 7);
	writeCSR(CSR_MTVEC, 0x69);
	setCSR(CSR_MTVEC, 1 << 31);
	putnum32(uart, readCSR(CSR_MTVEC));
	while (1);
}

void _start() {
	main();
}