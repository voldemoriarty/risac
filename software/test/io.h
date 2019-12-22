#include <unistd.h>

#define JTAG_UART ((volatile char*)(0x1000000))

/**
 * Write a string of characters to the ALTERA JTAG UART IP
 * Waits till the IP is ready to accept data and then writes a byte
 * @param uart: contains address of jtag uart peripheral
 * @param msg:	string to write
 * @param len:	length in bytes
 */
void _puts (volatile char* uart, const char* msg, const size_t len);

/**
 * Convert an integer to hexadecimal string
 * buff must have atleast 8 bytes
 * @param buff:	buffer to store the ascii characters
 * @param num:	32bit number to convert
 */
inline void _itoa (char *buff, int num) {
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
void putnum32(volatile char* uart, int num);