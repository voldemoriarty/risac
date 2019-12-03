library verilog;
use verilog.vl_types.all;
entity system_pll is
    port(
        areset          : in     vl_logic;
        inclk0          : in     vl_logic;
        c0              : out    vl_logic
    );
end system_pll;
