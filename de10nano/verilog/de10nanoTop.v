module de10nanoTop (
  input   clk,
  input   rstn,
  output  [9:0] leds,
  input   [9:0] switches
);

  soc_simple_De1_SoC rV_system (
    .clk_clk       	(clk),     //    clk.clk
    .reset_reset_n 	(rstn),    //  reset.reset_n
    .locked_export 	(),        // locked.export
    .leds_export   	(leds),     //   leds.export
	 .switches_export	(switches)	// switches.export
  );
  

endmodule 