library verilog;
use verilog.vl_types.all;
entity risac_avalon is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        avIB_readdata   : in     vl_logic_vector(31 downto 0);
        avIB_address    : out    vl_logic_vector(31 downto 0);
        avIB_waitrequest: in     vl_logic_vector(0 downto 0);
        avIB_read       : out    vl_logic_vector(0 downto 0);
        avDB_address    : out    vl_logic_vector(31 downto 0);
        avDB_readdata   : in     vl_logic_vector(31 downto 0);
        avDB_read       : out    vl_logic_vector(0 downto 0);
        avDB_writedata  : out    vl_logic_vector(31 downto 0);
        avDB_byteenable : out    vl_logic_vector(3 downto 0);
        avDB_write      : out    vl_logic_vector(0 downto 0);
        avDB_waitrequest: in     vl_logic_vector(0 downto 0)
    );
end risac_avalon;
