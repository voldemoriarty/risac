library verilog;
use verilog.vl_types.all;
entity risac is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        oIbusAddr       : out    vl_logic_vector(31 downto 0);
        iIbusData       : in     vl_logic_vector(31 downto 0);
        iIbusIAddr      : in     vl_logic_vector(31 downto 0);
        iIbusWait       : in     vl_logic;
        oIbusRead       : out    vl_logic;
        oDbusAddr       : out    vl_logic_vector(31 downto 0);
        oDbusWe         : out    vl_logic;
        oDbusData       : out    vl_logic_vector(31 downto 0);
        oDbusRead       : out    vl_logic;
        oDbusByteEn     : out    vl_logic_vector(3 downto 0);
        iDbusData       : in     vl_logic_vector(31 downto 0);
        iDbusWait       : in     vl_logic
    );
end risac;
