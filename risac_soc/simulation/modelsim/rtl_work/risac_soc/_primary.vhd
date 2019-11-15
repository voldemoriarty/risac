library verilog;
use verilog.vl_types.all;
entity risac_soc is
    port(
        clock50         : in     vl_logic;
        reset_n         : in     vl_logic;
        ledr            : out    vl_logic_vector(9 downto 0)
    );
end risac_soc;
