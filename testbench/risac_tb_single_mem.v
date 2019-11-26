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

  wire  [31:0]  rat0, rat1;

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

  assign rat0 = u_risac.rat[0];
  assign rat1 = u_risac.rat[1];

  reg [7:0] mem [0:4095]; // 4K ram
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
    $dumpfile("risac2.vcd");
    $dumpvars(0, testbench);
    $readmemh("program.vh", mem);

    $display ("\n======================");
    $display ("RISCV Virtual Terminal");
    $display ("======================\n"); 
    
    #5
    rst_n = 1'b1;



    #10000 
    // dump memory to output 
    $display ("======================\n"); 
    
    $finish;
  end

  // create a memory system
  // simple zero latency memory

  // ==========================
  // the instruction bus
  // ==========================
  reg [31:0] instr;
  always @ (oIbusAddr) begin 
    iIbusWait = 1'b0;
    instr = {mem [oIbusAddr+3], mem [oIbusAddr+2], mem [oIbusAddr+1], mem [oIbusAddr]};
    if (instr === 32'hxxxxxxxx) begin 
      instr = 32'b0;
    end
    iIbusData = instr;
    iIbusIAddr = oIbusAddr;
  end


  reg [7:0]  dmem_addr;
  reg [31:0] and_mask;

  always @ (cnt) begin 
    // the virtual console 
    if (oDbusWe && oDbusAddr == 32'h1000000 && oDbusByteEn[0]) begin 
      $write("%c", oDbusData[7:0]);		
    end
  end 

  reg [31:0] oldWord;

  always @ (*) begin 
    iDbusData = 'b0;
    iDbusWait = 'b0;
    
    if (oDbusWe) begin 
      mem[oDbusAddr]     = oDbusByteEn[0] ? oDbusData[07:00] : mem[oDbusAddr];
      mem[oDbusAddr + 1] = oDbusByteEn[1] ? oDbusData[15:08] : mem[oDbusAddr + 1];
      mem[oDbusAddr + 2] = oDbusByteEn[2] ? oDbusData[23:16] : mem[oDbusAddr + 2];
      mem[oDbusAddr + 3] = oDbusByteEn[3] ? oDbusData[31:24] : mem[oDbusAddr + 3];
    end
    
    if (oDbusRead) begin 
      if (oDbusAddr == 32'h1000004) begin  
      iDbusData = 32'h00402000;      
      end else begin 
      iDbusData = {mem[oDbusAddr + 3], mem[oDbusAddr + 2], mem[oDbusAddr + 1], mem[oDbusAddr]};
      end
    end
  end

endmodule 