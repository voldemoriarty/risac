library verilog;
use verilog.vl_types.all;
entity risac_soc_system_uart_0 is
    port(
        address         : in     vl_logic_vector(2 downto 0);
        begintransfer   : in     vl_logic;
        chipselect      : in     vl_logic;
        clk             : in     vl_logic;
        read_n          : in     vl_logic;
        reset_n         : in     vl_logic;
        rxd             : in     vl_logic;
        write_n         : in     vl_logic;
        writedata       : in     vl_logic_vector(15 downto 0);
        dataavailable   : out    vl_logic;
        irq             : out    vl_logic;
        readdata        : out    vl_logic_vector(15 downto 0);
        readyfordata    : out    vl_logic;
        txd             : out    vl_logic
    );
end risac_soc_system_uart_0;
