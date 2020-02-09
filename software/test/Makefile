# simple makefile for compiling C programs
# supports both stdlib and simple

# to use stdlib, just use link_stdlib.ld
# and comment the -nostdlib line
LFLAGS =  -O3 -Wall -T link_simple.ld
LFLAGS += -nostdlib
CFLAGS =  -nostdlib
CFLAGS += -O3 -march=rv32i -mabi=ilp32 -c -Wall

CSRC = start.c test.c io.c
OBJS = $(CSRC:.c=.o)
ASMS = $(CSRC:.c=.s)

TGT = program

# path to the riscv32 toolchain
# in this case, i assume it is in PATH
TOOLCHAIN = riscv32-unknown-elf-

CC = $(TOOLCHAIN)gcc
OC = $(TOOLCHAIN)objcopy
SZ = $(TOOLCHAIN)size
OD = $(TOOLCHAIN)objdump
BM = ../bin2hex/bin2hex

.PHONY: all
.PHONY: clean
.PHONY: elf
.PHONY: asm
.PHONY: sim
.PHONY: de10Flash
.PHONY: dump

%.o: %.c
	$(CC) $(CFLAGS) $<

%.s: %.c
	$(CC) -S $(CFLAGS) $<

$(TGT).elf: $(OBJS)
	$(CC) $(LFLAGS) $(OBJS) -o $@

$(TGT).bin: $(TGT).elf 
	$(OC) -O binary $< $@

$(TGT).mif: $(TGT).bin
	$(BM) $< $@
	cp $@ ../../de10nano/hex/
	cp $@ ../../de10nano/simulation/modelsim/hex/

$(TGT).vh: $(TGT).elf 
	$(OC) -O verilog $< $@

size: $(TGT).elf
	$(SZ) $<

elf: $(TGT).elf

asm: $(ASMS)

dump: $(TGT).elf
	$(OD) -d $< | less

sim: $(TGT).vh
	cp $< ../../testbench/

all: $(TGT).elf $(TGT).bin $(TGT).mif $(TGT).vh

de10Flash: $(TGT).mif
	make --directory=../../de10nano/ prog

clean:
	rm *.mif *.bin *.elf *.o *.s *.vh
