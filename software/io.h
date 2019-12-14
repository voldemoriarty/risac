#include <unistd.h>

/**
 * Write a string of characters to the ALTERA JTAG UART IP
 * Waits till the IP is ready to accept data and then writes a byte
 * @param uart: contains address of jtag uart peripheral
 * @param msg:	string to write
 * @param len:	length in bytes
 */
void _puts (volatile char* uart, const char* msg, const size_t len);