/*
	simple link script for risac
*/

ENTRY(_actual_start)

MEMORY 
{
	RAM (rwx): ORIGIN = 0x0, LENGTH = 128K
}

/* stack pointer is the highest stack address */
PROVIDE(_stack_pointer = ORIGIN(RAM) + LENGTH(RAM));
PROVIDE( __global_pointer$ = (4K / 2) );

SECTIONS
{
	.text : 
	{
		*(.text.init)	/* containing our actual startup code */
		*(.text)
		*(.text.*)
	} > RAM

	. = ALIGN(4);

	.data :
	{
		*(.data)
		*(.data.*)
		*(.sdata .sdata.*)
		_edata = .;
	} > RAM

	. = ALIGN(4);

	.bss : 
	{
		*(.bss)
		*(.bss.*)
		*(COMMON)
		_end = .;
	} > RAM 
}
