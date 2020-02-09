
module soc_simple_De1_SoC (
	clk_clk,
	leds_export,
	locked_export,
	reset_reset_n,
	switches_export);	

	input		clk_clk;
	output	[9:0]	leds_export;
	output		locked_export;
	input		reset_reset_n;
	input	[9:0]	switches_export;
endmodule
