library verilog;
use verilog.vl_types.all;
entity soc_simple_de1_rsp_xbar_mux_001 is
    port(
        sink0_valid     : in     vl_logic;
        sink0_data      : in     vl_logic_vector(100 downto 0);
        sink0_channel   : in     vl_logic_vector(3 downto 0);
        sink0_startofpacket: in     vl_logic;
        sink0_endofpacket: in     vl_logic;
        sink0_ready     : out    vl_logic;
        sink1_valid     : in     vl_logic;
        sink1_data      : in     vl_logic_vector(100 downto 0);
        sink1_channel   : in     vl_logic_vector(3 downto 0);
        sink1_startofpacket: in     vl_logic;
        sink1_endofpacket: in     vl_logic;
        sink1_ready     : out    vl_logic;
        sink2_valid     : in     vl_logic;
        sink2_data      : in     vl_logic_vector(100 downto 0);
        sink2_channel   : in     vl_logic_vector(3 downto 0);
        sink2_startofpacket: in     vl_logic;
        sink2_endofpacket: in     vl_logic;
        sink2_ready     : out    vl_logic;
        sink3_valid     : in     vl_logic;
        sink3_data      : in     vl_logic_vector(100 downto 0);
        sink3_channel   : in     vl_logic_vector(3 downto 0);
        sink3_startofpacket: in     vl_logic;
        sink3_endofpacket: in     vl_logic;
        sink3_ready     : out    vl_logic;
        src_valid       : out    vl_logic;
        src_data        : out    vl_logic_vector(100 downto 0);
        src_channel     : out    vl_logic_vector(3 downto 0);
        src_startofpacket: out    vl_logic;
        src_endofpacket : out    vl_logic;
        src_ready       : in     vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic
    );
end soc_simple_de1_rsp_xbar_mux_001;
