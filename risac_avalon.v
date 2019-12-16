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
  input		[00:0] avDB_waitrequest,

  // timer overflow conduit
  input   [00:0] con_tim_overflow
);
  reg   read;
  wire  cpu_read;
  assign avIB_read = read;

  always @ (negedge clk or negedge rst_n) begin 
    if (!rst_n) begin 
      read <= 'b0;
    end else begin 
      read <= cpu_read;
    end
  end

  // edge detector for the waitrequest signal
  reg wr_old;
  always @ (posedge clk or negedge rst_n) begin 
    if (!rst_n) begin 
      wr_old <= 1'b0;
    end else begin 
      wr_old <= avIB_waitrequest;
    end
  end

  wire wr_negedge = ~avIB_waitrequest & wr_old;

  // save the data in the line
  reg [31:0] ibusdata_old;
  always @ (posedge clk or negedge rst_n) begin 
    if (!rst_n) begin 
      ibusdata_old <= 'b0;
    end else if (wr_negedge) begin 
      ibusdata_old <= avIB_readdata;
    end
  end

  wire [3:0] byten;
  wire [31:0] wdata;

  assign avDB_byteenable = byten << avDB_address[1:0];
  assign avDB_writedata = wdata << (avDB_address[1:0] * 8);
  
  risac u_risac (
    .clk        (clk),
    .rst_n      (rst_n),
    
    .oIbusAddr  (avIB_address),
    .iIbusData  (wr_negedge ? avIB_readdata : ibusdata_old),
    .iIbusIAddr (avIB_address),
    .iIbusWait  (avIB_waitrequest),
    .oIbusRead  (cpu_read),

    .oDbusAddr  (avDB_address),
    .oDbusWe    (avDB_write),
    .oDbusData  (wdata),
    .oDbusRead  (avDB_read),
    .oDbusByteEn(byten),
    .iDbusData  (avDB_readdata >> (avDB_address[1:0] * 8)),
    .iDbusWait	(avDB_waitrequest),

    .tim_overflow(con_tim_overflow)
  );
  
endmodule 