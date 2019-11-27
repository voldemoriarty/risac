module risac_avalon (
  input	clk,
  input rst_n,

  // imem
  input 	[31:0] avIB_readdata,
  output	[31:0] avIB_address,
  input 	[00:0] avIB_waitrequest,
  output  [00:0] avIB_read,

  // dmem
  output 	[31:0] avDB_address,
  input		[31:0] avDB_readdata,
  output  [00:0] avDB_read,
  output  [31:0] avDB_writedata,
  output  [03:0] avDB_byteenable,
  output  [00:0] avDB_write,
  input		[00:0] avDB_waitrequest
);

  risac u_risac (
    .clk        (clk),
    .rst_n      (rst_n),
    
    .oIbusAddr  (avIB_address),
    .iIbusData  (avIB_readdata),
    .iIbusIAddr (avIB_address),
    .iIbusWait  (avIB_waitrequest),
    .oIbusRead  (avIB_read),

    .oDbusAddr  (avDB_address),
    .oDbusWe    (avDB_write),
    .oDbusData  (avDB_writedata),
    .oDbusRead  (avDB_read),
    .oDbusByteEn(avDB_byteenable),
    .iDbusData  (avDB_readdata >> (avDB_address[1:0] * 8)),
    .iDbusWait	(avDB_waitrequest)
  );
  
endmodule 