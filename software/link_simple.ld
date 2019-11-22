/*
	simple link script for risac
*/

ENTRY(_actual_start)

MEMORY 
{
	RAM (rwx): ORIGIN = 0x0, LENGTH = 4K
}

/* stack pointer is the highest stack address */
PROVIDE(_stack_pointer = ORIGIN(RAM) + LENGTH(RAM));

SECTIONS
{
	.text : 
	{
		*(.text.init)
		*(.text)
		*(.text.*)
	} > RAM

	. = ALIGN(4);

	.data :
	{
		*(.data)
		*(.data.*)
	} > RAM

	. = ALIGN(4);

	.bss : 
	{
		*(.bss)
		*(.bss.*)
		*(COMMON)
	} > RAM 
}
