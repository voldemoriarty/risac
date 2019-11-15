library verilog;
use verilog.vl_types.all;
entity risac_soc_system_uart_0_regs is
    port(
        address         : in     vl_logic_vector(2 downto 0);
        break_detect    : in     vl_logic;
        chipselect      : in     vl_logic;
        clk             : in     vl_logic;
        clk_en          : in     vl_logic;
        framing_error   : in     vl_logic;
        parity_error    : in     vl_logic;
        read_n          : in     vl_logic;
        reset_n         : in     vl_logic;
        rx_char_ready   : in     vl_logic;
        rx_data         : in     vl_logic_vector(7 downto 0);
        rx_overrun      : in     vl_logic;
        tx_overrun      : in     vl_logic;
        tx_ready        : in     vl_logic;
        tx_shift_empty  : in     vl_logic;
        write_n         : in     vl_logic;
        writedata       : in     vl_logic_vector(15 downto 0);
        baud_divisor    : out    vl_logic_vector(8 downto 0);
        dataavailable   : out    vl_logic;
        do_force_break  : out    vl_logic;
        irq             : out    vl_logic;
        readdata        : out    vl_logic_vector(15 downto 0);
        readyfordata    : out    vl_logic;
        rx_rd_strobe    : out    vl_logic;
        status_wr_strobe: out    vl_logic;
        tx_data         : out    vl_logic_vector(7 downto 0);
        tx_wr_strobe    : out    vl_logic
    );
end risac_soc_system_uart_0_regs;
