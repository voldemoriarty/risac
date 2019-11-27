`timescale 1ps / 1ps

module tb;
	
	reg 	clk = 0, rstn = 0;
	wire 	[7:0]	leds;
	de10nanoTop uut (clk, rstn, leds);
	
	reg [7:0] str [0:255];
	integer i;

	always begin 
		#10000 clk = !clk;
	end

	always @ * begin 
		if (uut.rV_system.rv32i_core.avDB_address == 32'h1000000 && uut.rV_system.rv32i_core.avDB_write) begin 
			str[i] = uut.rV_system.rv32i_core.avDB_writedata[7:0];
			i = i + 1;
		end
	end
	
	initial begin
		for (i = 0; i < 256; i = i + 1) str[i] = 'b0;
		i = 0;
		#60000 rstn = 1;
	end
	
endmodule 