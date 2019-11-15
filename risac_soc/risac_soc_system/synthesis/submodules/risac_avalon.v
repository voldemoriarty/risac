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

	assign avIB_read = 1'b1;

	risac u_risac (
		.clk        (clk),
		.rst_n      (rst_n),
		
		.oIbusAddr  (avIB_address),
		.iIbusData  (avIB_readdata),
		.iIbusIAddr ('b0),
		.iIbusWait  (avIB_waitrequest),

		.oDbusAddr  (avDB_address),
		.oDbusWe    (avDB_write),
		.oDbusData  (avDB_writedata),
		.oDbusRead  (avDB_read),
		.oDbusByteEn(avDB_byteenable),
		.iDbusData  (avDB_readdata),
		.iDbusWait	(avDB_waitrequest)
	);
endmodule 