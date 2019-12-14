extern void _start();

// the actual entry point
// for now, only call main
__attribute__((section (".text.init")))
void _actual_start () {
	// setup the stack
	// must needed for both stdlib and newlib versions
	// since newlib assumes that stack has already been setup
	__asm("la gp, __global_pointer$");
	__asm("la sp, _stack_pointer");
	_start();
}