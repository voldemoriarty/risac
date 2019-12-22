
LFLAGS =  -Os -Wall -T link_freertos.ld

CFLAGS =  -I .. -I .
CFLAGS += -Os -march=rv32i -mabi=ilp32 -c -Wall

CSRC = start.c io.c
CSRC += croutine.c event_groups.c heap_1.c list.c main_blinky.c main.c port.c 
CSRC += queue.c stream_buffer.c tasks.c timers.c


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

portASM.o: portASM.s
	$(CC) $(CFLAGS) $<


%.o: %.c
	$(CC) $(CFLAGS) $<

%.s: %.c
	$(CC) -S $(CFLAGS) $<

$(TGT).elf: $(OBJS) portASM.o
	$(CC) $(LFLAGS) $(OBJS) portASM.o -o $@

$(TGT).bin: $(TGT).elf 
	$(OC) -O binary $< $@

$(TGT).mif: $(TGT).bin
	$(BM) $< $@
	cp $@ ../../de10nano/hex/
	cp $@ ../../de10nano/simulation/modelsim/hex/

size: $(TGT).elf
	$(SZ) $<

elf: $(TGT).elf

asm: $(ASMS)

dump: $(TGT).elf
	$(OD) -d $< | less

all: $(TGT).elf $(TGT).bin $(TGT).mif

de10Flash: $(TGT).mif
	make --directory=../../de10nano/ prog

clean:
	rm *.mif *.bin *.elf *.o *.s
