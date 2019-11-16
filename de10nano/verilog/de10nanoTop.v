module de10nanoTop (
  input   clk,
  input   rstn,
  output  [7:0] leds
);

  soc_simple rV_system (
    .clk_clk       (clk),     //    clk.clk
    .reset_reset_n (rstn),    //  reset.reset_n
    .locked_export (),        // locked.export
    .leds_export   (leds)     //   leds.export
  );

endmodule 