`timescale 1ps / 1ps

module tb;
	
	reg 	clk = 0, rstn = 0;
	wire 	[7:0]	leds;
	de10nanoTop uut (clk, rstn, leds);

	always begin 
	#10000 clk = !clk;
	end
	
	initial begin 
	#60000 rstn = 1;
	end
	
endmodule 