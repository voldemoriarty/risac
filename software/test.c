/**
 * A simple test code to check how gcc works with our cpu
 * goals:
 * 1. write code, begin at _start(); use -nostdlib
 * 2. use a linker script to link it together
 * 3. use objcopy to get an intel hex format file
 */

void _puts (volatile char* uart, const char* msg, const int len) {
	volatile unsigned int *status = (volatile unsigned int *)uart;
	for (int i = 0; i < len; ++i) {
		while (status[1] >> 16 == 0);
		*uart = msg[i];
	}
}
/**
 * Convert an integer to hexadecimal string
 * buff must have atleast 8 bytes
 */
void _itoa (char *buff, int num) {
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

// the (fake) entry point
int main () {
	volatile char *leds = (volatile char *)0x2000000;
	*leds = 0x50;
	volatile char *uart = (volatile char *)0x1000000;
	
	char buffer[10];

	buffer[8] = '\r';
	buffer[9] = '\n';
	
	for (int i = 0xff; i < 0xff + 2; ++i) {
		_itoa(buffer, i);
		_puts(uart, "0x", 2);
		_puts(uart, buffer, 10);
	}
	while (1);
}

void _start () {
	main();
}