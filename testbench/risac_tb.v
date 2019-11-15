`timescale 1ns / 1ps

module testbench();

	reg						clk = 1, rst_n = 0;
	wire	[31:0] 	oIbusAddr;
	reg		[31:0] 	iIbusData;
	reg		[31:0]	iIbusIAddr;
	reg						iIbusWait;
	
	wire	[31:0]	oDbusAddr;
	wire					oDbusWe;
	wire	[31:0]	oDbusData;
	wire					oDbusRead;
	wire	[3:0]		oDbusByteEn;
	reg		[31:0]	iDbusData;
	reg						iDbusWait;

	risac u_risac (
		.clk          (clk),
		.rst_n        (rst_n),

		// The IBUS

		.oIbusAddr    (oIbusAddr),
		.iIbusData    (iIbusData),
		.iIbusIAddr   (iIbusIAddr),
		.iIbusWait    (iIbusWait),
		
		// The DBUS

		.oDbusAddr    (oDbusAddr),
		.oDbusWe      (oDbusWe),
		.oDbusData    (oDbusData),
		.oDbusRead    (oDbusRead),
		.oDbusByteEn  (oDbusByteEn),
		.iDbusData    (iDbusData),
		.iDbusWait    (iDbusWait)
	);


	reg [31:0] imem [0:255];
	reg [31:0] dmem [0:255];
	reg [31:0] cnt = 0;

	// create a clock
	always @ (posedge clk) begin 
		cnt = cnt + 1;
	end

	always begin 
		#10 
		clk = !clk;
	end

	// initialize the memories
	integer i;
	initial begin 
		// prepare a vcd dump
		$dumpfile("risac.vcd");
		$dumpvars(0, testbench);

		$readmemh("imem.hex", imem);
		$readmemh("dmem.hex", dmem);

		$display ("\n======================");
		$display ("RISCV Virtual Terminal");
		$display ("======================\n"); 
		
		#5
		rst_n = 1'b1;



		#5000 
		// dump memory to output 
		$display ("======================\n"); 
		$display ("dmem dump (first 10 words)");
		for (i = 0; i < 10; i=i+1) begin 
			$display("dmem[%0d] = 0x%x", i, dmem[i]);
		end
		
		$finish;
	end

	// create a memory system
	// simple zero latency memory

	// ==========================
	// the instruction bus
	// ==========================

	always @ (oIbusAddr) begin 
		iIbusWait <= 1'b0;
		iIbusData <= imem [oIbusAddr[9:2]];
		iIbusIAddr<= oIbusAddr;
	end


	reg [7:0]  dmem_addr;
	reg [31:0] and_mask;

	always @ (cnt) begin 
		// the virtual console 
		if (oDbusWe && oDbusAddr == 32'b0 && oDbusByteEn[0]) begin 
			$write("%c", oDbusData[7:0]);		
		end
	end 

	reg [31:0] oldWord;

	always @ (*) begin 
		iDbusData = 'b0;
		iDbusWait = 'b0;
		dmem_addr = oDbusAddr[9:2];

		if (oDbusWe) begin 
			oldWord = dmem[dmem_addr];

			if (oDbusByteEn == 4'h1) begin 
				case (oDbusAddr[1:0]) 
				2'd0: dmem[dmem_addr][07:00] = oDbusData[7:0];
				2'd1: dmem[dmem_addr][15:08] = oDbusData[7:0];
				2'd2: dmem[dmem_addr][23:16] = oDbusData[7:0];
				2'd3: dmem[dmem_addr][31:24] = oDbusData[7:0];
				endcase
			end else if (oDbusByteEn == 4'h3) begin 
				case (oDbusAddr[1])
				1'd0: dmem[dmem_addr][15:00] = oDbusData[15:0];
				1'd1: dmem[dmem_addr][31:16] = oDbusData[15:0];
				endcase
			end else if (oDbusByteEn == 4'hf) begin 
				dmem[dmem_addr] = oDbusData;
			end
		end
		
		if (oDbusRead) begin 
			iDbusData = dmem[dmem_addr];
		end
	end

endmodule 