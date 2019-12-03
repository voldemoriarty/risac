library verilog;
use verilog.vl_types.all;
entity soc_simple_de1 is
    port(
        clk_clk         : in     vl_logic;
        reset_reset_n   : in     vl_logic;
        ledg_export     : out    vl_logic_vector(7 downto 0);
        ledr_export     : out    vl_logic_vector(9 downto 0)
    );
end soc_simple_de1;
