PROJ := de10nanoTop
all:
	quartus_cdb --update_mif $(PROJ)
	quartus_asm $(PROJ)

prog: all
	quartus_pgm -m jtag -o "p;output_files/de10nanoTop.sof@2"
	nios2-terminal