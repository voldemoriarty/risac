/**
 * A simple test code to check how gcc works with our cpu
 * goals:
 * 1. write code, begin at _start(); use -nostdlib
 * 2. use a linker script to link it together
 * 3. use objcopy to get an intel hex format file
 */


/**
 * Write a string of characters to the ALTERA JTAG UART IP
 * @param uart: contains address of jtag uart peripheral
 * @param msg:	string to write
 * @param len:	length in bytes
 */
static void _puts (volatile char* uart, const char* msg, const int len) {
	volatile unsigned int *status = (volatile unsigned int *)uart;
	for (int i = 0; i < len; ++i) {
		while (status[1] >> 16 == 0);
		*uart = msg[i];
	}
}

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
static int main () {
	volatile char *leds = (volatile char *)0x2000000;
	*leds = 0x50;
	volatile char *uart = (volatile char *)0x1000000;
	_puts (uart, "Now running: Count from -1 to 9\r\n", 34);
	for (int i = -1; i < 10; ++i) {
		putnum32(uart, i);
		_puts(uart, "\r\n", 2);
	}
	// loopback uart 
	_puts (uart, "Now running: UART Loopback\r\n", 29);
	while (1) {
		// if read data is available, write it for loopback
		volatile unsigned *data = (volatile unsigned *)uart;
		unsigned d = data[0];
		if (d & (1 << 15)) {
			_puts(uart, (char*)&d, 1);
			*leds = *(char*)&d;
		}
	}
}

void _start () {
	main();
}

void *memcpy (void *dst, const void *src, unsigned len) {
	char *d = (char*)dst;
	const char *s = (const char *)src;
	for (unsigned i = 0; i < len; ++i) {
		d[i] = s[i];
	}
	return dst;
}