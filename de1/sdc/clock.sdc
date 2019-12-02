create_clock -add -name core_clock -period 20.0 [get_ports {clk}]

derive_pll_clocks