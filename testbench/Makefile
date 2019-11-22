risac.out: ../risac.v risac_tb.v
	iverilog ../risac.v risac_tb.v -o risac.out 

risac2.out: ../risac.v risac_tb_single_mem.v
	iverilog ../risac.v risac_tb_single_mem.v -o risac2.out 

risac.vcd: risac.out imem.hex dmem.hex
	vvp risac.out 

risac2.vcd: risac2.out program.vh
	vvp risac2.out 

all: risac.vcd

sim: risac.out
	vvp risac.out

sim2: risac2.out
	vvp risac2.out

clean:
	rm risac.out risac.vcd 
	rm risac2.out risac2.vcd 

wave: risac.vcd risac.gtkw
	gtkwave risac.gtkw 

wave2: risac2.vcd risac2.gtkw
	gtkwave risac2.gtkw 