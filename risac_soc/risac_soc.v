`timescale 1ns/1ps

module risac_soc (
	input		clock50,
	input 	reset_n,
	output 	[9:0] ledr
);

	risac_soc_system soc_system (
		.clk_clk                      (clock50),    //                   clk.clk
		.reset_reset_n                (reset_n),    //                 reset.reset_n
		.ledr_export                  (ledr)        //                  ledr.export
	);

endmodule 

module risac_soc_tb;
	reg clk = 0, rstn = 0;
	wire [9:0] ledr;
	
	risac_soc uut (clk, rstn, ledr);

	always #10 clk = !clk;
	
	initial begin 
		#30 rstn = 1;
		
		#1000 $stop;
	end
endmodule 