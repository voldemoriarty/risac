#include "io.h"
#include "csr.h"
#include "timer.h"

void trap (void) __attribute__ ((interrupt ("machine")));

volatile int count = 0;
volatile int trapcount = 0;

void trap () {
	volatile char *uart = (volatile char *)0x1000000;
	volatile int *leds = (volatile int *)  0x2000010;

	volatile unsigned int *status = (volatile unsigned int *)uart;
	// disable interrupts
	clrCSR(CSR_MIE, 1 << 7);
	count++;

	if (count == 99) {
		/**
		 * check the AC bit to see if JTAG is connected
		 * to the host software. If it isn't then no need
		 * to send the data
		 */
		unsigned ac = (status[1] >> 10) & 1;
		if (ac) {
			_puts(uart, "ITS A TRAP:", 12);
			putnum32(uart, ++trapcount);
			_puts(uart, "\n", 2);	
			count = 0;
			/**
			 * clear the AC bit by writing 1
			 */
			status[1] |= 1 << 10;
		}
	}

	*leds = *leds + 1;
	writeMTime(0);
	
	// re-enable interrupts
	setCSR(CSR_MIE, 1 << 7);
}

// the (fake) entry point
int main () {
	volatile char *uart = (volatile char *)0x1000000;
	volatile int *switches = (volatile int *)0x2000000;
	volatile int *leds = (volatile int *)0x2000010;

	*leds = 0;
	while(1)
	{
		if (*switches > 512)
		{
			*leds = 0;
			writeCSR(CSR_MTVEC, (unsigned)trap);
			setCSR(CSR_MIE, 1 << 7);
			putnum32(uart, readCSR(CSR_MTVEC));
			_puts(uart, "\n", 1);
		
			writeMTimecmp(50000000);
			break;
		}
		else
			*leds = *switches;
	}
	while (1);
}

void _start() {
	main();
}