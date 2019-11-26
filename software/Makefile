# simple makefile for compiling C programs
# supports both stdlib and simple

# to use stdlib, just use link_stdlib.ld
# and comment the -nostdlib line
LFLAGS =  -T link_simple.ld
LFLAGS += -nostdlib
CFLAGS =  -nostdlib
CFLAGS += -O3 -march=rv32i -mabi=ilp32 -c

CSRC = start.c test.c
OBJS = $(CSRC:.c=.o)
ASMS = $(CSRC:.c=.s)

TGT = program

# path to the riscv32 toolchain
# in this case, i assume it is in PATH
TOOLCHAIN = riscv32-unknown-elf-

CC = $(TOOLCHAIN)gcc
OC = $(TOOLCHAIN)objcopy
SZ = $(TOOLCHAIN)size
BM = ./bin2hex/bin2hex

.PHONY: all
.PHONY: clean
.PHONY: elf
.PHONY: asm
.PHONY: sim

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
	cp $@ -v ../de10nano/hex/

$(TGT).vh: $(TGT).elf 
	$(OC) -O verilog $< $@

size: $(TGT).elf
	$(SZ) $<

elf: $(TGT).elf

asm: $(ASMS)

sim: $(TGT).vh
	cp $< ../testbench/

all: $(TGT).elf $(TGT).bin $(TGT).mif $(TGT).vh


clean:
	rm *.mif *.bin *.elf *.o *.s