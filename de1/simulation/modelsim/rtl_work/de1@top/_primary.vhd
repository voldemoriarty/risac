library verilog;
use verilog.vl_types.all;
entity de1Top is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        ledg            : out    vl_logic_vector(7 downto 0);
        ledr            : out    vl_logic_vector(9 downto 0)
    );
end de1Top;
