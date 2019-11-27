/**
 * A simple test code to check how gcc works with our cpu
 * goals:
 * 1. write code, begin at _start(); use -nostdlib
 * 2. use a linker script to link it together
 * 3. use objcopy to get an intel hex format file
 */

inline void delay () {
	for (volatile unsigned i = 0; i < 100000; ++i);
}

inline void _puts (volatile char* uart, const char* msg, const int len) {
	volatile unsigned int *status = (volatile unsigned int *)uart;
	for (int i = 0; i < len; ++i) {
		// while (status[1] >> 16 == 0);
		*uart = msg[i];
	}
}

// the (fake) entry point
int main () {
	volatile char *leds = (volatile char *)0x2000000;
	*leds = 0x55;
	volatile char *uart = (volatile char *)0x1000000;
	_puts(uart, "Welcome Dr Awais\r\n", 19);
	while (1);
}

void _start () {
	main();
}