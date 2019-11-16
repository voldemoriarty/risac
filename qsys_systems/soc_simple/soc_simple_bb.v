
module soc_simple (
	clk_clk,
	leds_export,
	locked_export,
	reset_reset_n);	

	input		clk_clk;
	output	[7:0]	leds_export;
	output		locked_export;
	input		reset_reset_n;
endmodule
