module de1Top (
	input clk, rst,
	output [7:0] ledg,
	output [9:0] ledr
);
	wire soc_clk;
	
	system_pll	system_pll_inst (
		.areset ( rst ),
		.inclk0 ( clk ),
		.c0 ( soc_clk )
	);
	
	soc_simple_de1 u0 (
		.clk_clk       (soc_clk), //   clk.clk
		.reset_reset_n (rst), 		// reset.reset_n
		.ledg_export   (ledg),   	//  ledg.export
		.ledr_export   (ledr)    	//  ledr.export
	);
endmodule 