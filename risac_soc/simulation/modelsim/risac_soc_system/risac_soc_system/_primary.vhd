library verilog;
use verilog.vl_types.all;
entity risac_soc_system is
    port(
        clk_clk         : in     vl_logic;
        reset_reset_n   : in     vl_logic;
        ledr_export     : out    vl_logic_vector(9 downto 0)
    );
end risac_soc_system;
