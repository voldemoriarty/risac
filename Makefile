risac.out: risac.v risac_tb.v
	iverilog risac.v risac_tb.v -o risac.out 

risac.vcd: risac.out imem.hex dmem.hex
	vvp risac.out 

all: risac.vcd

sim: risac.out
	vvp risac.out

wave: risac.vcd risac.gtkw
	gtkwave risac.gtkw 