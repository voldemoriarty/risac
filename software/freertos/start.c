extern void _start();

// the actual entry point
// for now, only call main
__attribute__((section (".text.init")))
void _actual_start () {
	// setup the stack
	// must needed for both stdlib and newlib versions
	// since newlib assumes that stack has already been setup
	__asm("addi x1,x0,0");
	__asm("addi x2,x0,0");
	__asm("addi x3,x0,0");

	__asm("addi x4,x0,0");
	__asm("addi x5,x0,0");
	__asm("addi x6,x0,0");
	__asm("addi x7,x0,0");

	__asm("addi x8,x0,0");
	__asm("addi x9,x0,0");
	__asm("addi x10,x0,0");
	__asm("addi x11,x0,0");

	__asm("addi x12,x0,0");
	__asm("addi x13,x0,0");
	__asm("addi x14,x0,0");
	__asm("addi x15,x0,0");

	__asm("addi x16,x0,0");
	__asm("addi x17,x0,0");
	__asm("addi x18,x0,0");
	__asm("addi x19,x0,0");

	__asm("addi x20,x0,0");
	__asm("addi x21,x0,0");
	__asm("addi x22,x0,0");
	__asm("addi x23,x0,0");

	__asm("addi x24,x0,0");
	__asm("addi x25,x0,0");
	__asm("addi x26,x0,0");
	__asm("addi x27,x0,0");

	__asm("addi x28,x0,0");
	__asm("addi x29,x0,0");
	__asm("addi x30,x0,0");
	__asm("addi x31,x0,0");
	
	__asm("la gp, __global_pointer$");
	__asm("la sp, _stack_pointer");
	
	_start();
}