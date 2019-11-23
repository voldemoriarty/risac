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
	for (int i = 0; i < len; ++i) {
		*uart = msg[i];
	}
}

// the (fake) entry point
int main () {
	volatile int *leds = (int*) (0x80000);
	
	// altera jtag uart
	volatile int *uart = (int*) (0x10000);

	int count = 0;

	_puts((volatile char*)uart, "Hello, World!\n", 15);

	while (1) {
		delay();
		delay();
		*leds = count++;
	}
}

void _start () {
	main();
}