module risac (
  input						clk, rst_n,
  output	[31:0] 	oIbusAddr,
  input		[31:0] 	iIbusData,
  input		[31:0]	iIbusIAddr,
  input						iIbusWait,
  output          oIbusRead,
  
  output	[31:0]	oDbusAddr,
  output					oDbusWe,
  output	[31:0]	oDbusData,
  output					oDbusRead,
  output	[3:0]		oDbusByteEn,
  input		[31:0]	iDbusData,
  input						iDbusWait
);

  // ===========================================================
  // the instruction address generation logic
  // pc contains the byte address
  reg [31:0] pc;
  reg [31:0] branchTarget;
  reg branch;
  reg dataHazard;
  reg stallPipe;
  reg pcChanged;
  reg [4:0]		rdOf;
  

  assign oIbusAddr = pc;
  // wait for waitrequest to fall before zeroing
  // read (i.e.) wait till a pending request is completed
  assign oIbusRead = iIbusWait ? 1'b1 : pcChanged;

  reg [31:0] branchTarget2;
  reg use2;

  always @ (posedge clk or negedge rst_n) begin: IF
    if (!rst_n) begin 
      pc <= 'b0;
      pcChanged <= 'b1;
      branchTarget2 <= 'b0;
      use2 <= 'b0;
    end	else if ((!stallPipe && !dataHazard) | branch) begin 
      // new data arrives when wait is 0
      // so update pc when wait is 0
      // pc <= iIbusWait ? pc : (branch ? (use2 ? branchTarget2 : branchTarget) : pc + 3'd4);

      if (!iIbusWait) begin 
        if (use2) begin 
          pc <= branchTarget2;
        end else if (branch) begin
          pc <= branchTarget;
        end else begin 
          pc <= pc + 3'd4;
        end
      end

      if (branch && iIbusWait) begin 
        branchTarget2 <= branchTarget;
        use2 <= 1'b1;
      end else if (use2 && !iIbusWait) begin 
        use2 <= 1'b0;
      end

      // assert read regardless of wait
      // but only when pc is updated
      // also dont deassert when wait is high
      // pcChanged <= iIbusWait ? 1'b0 : 1'b1;
      if (!iIbusWait) begin 
        pcChanged <= 1'b1;
      end else begin 
        pcChanged <= 1'b0;
      end
    end else begin
      pcChanged <= 1'b0;
    end
  end

  // ===========================================================
  // decode the instruction 
  // for now support only rtype, itype and stype

  reg [3:0]		aluOpDec;
  reg [4:0]		rs1Dec, rs2Dec, rdDec;
  reg [31:0]	immDec, pcDec, rs1ShiftDec, rs2ShiftDec, rdShiftDec;
  reg 				validDec;
  reg					immSelDec;
  reg 				rdWeDec;
  reg					illegalDec;
  reg					lDec, sDec, luipcDec, luiDec;
  reg         branchDec;
  reg         branchType;
  reg					jalr;
  reg [4:0]		rdEx;
  reg					validOf, rdWeOf, immSelOf;	

  always @ (posedge clk or negedge rst_n) begin: DEC
    if (!rst_n) begin 
      {aluOpDec, rs1Dec, rs2Dec, immDec, validDec, immSelDec, rdShiftDec} <= 'b0;
      {rdWeDec, illegalDec, pcDec, lDec, sDec, rs1ShiftDec, rs2ShiftDec} <= 'b0; 
      {luipcDec, luiDec, branchDec, branchType, jalr} <= 'b0;
    end else if (!stallPipe && !dataHazard) begin 
      // the address of the currently being decoded instruction
      pcDec			<= iIbusIAddr;

      // the instruction is valid if there is not wait signal
      validDec	<= ~iIbusWait & ~(branch | use2);

      // decode the instruction regardless of validity

      // branch instructions
      // only branch opcodes begin with 110
      branchDec   <= iIbusData[6:4] == 3'b110;
      // for conditional branches, the next 2 bits are zero
      // branchType: zero for unconditional, 1 for conditional
      // for all branches, pc <= pc + offset
      // except jalr, pc <= rs1 + offset 
      branchType  <= iIbusData[3:2] == 2'b00;
      jalr <= iIbusData[3:2] == 2'b01;

      // lui and auipc are special
      luipcDec <= iIbusData[4:2] == 3'b101;
      luiDec   <= iIbusData[5:2] == 4'b1101;

      // alu op is always [14:12]
      aluOpDec[2:0]	<= iIbusData[14:12];
      aluOpDec[3]		<= iIbusData[30];

      // rs1, rs2 and rd are fixed
      rs1Dec			<= iIbusData[19:15];
      rs2Dec			<= iIbusData[24:20];
      rs1ShiftDec	<= 1 << iIbusData[19:15];
      rs2ShiftDec <= 1 << iIbusData[24:20];
      rdDec				<= iIbusData[11:7];
      rdShiftDec 	<= 1 << iIbusData[11:7];

      // always write to rd except when storing or conditional branching
      // all instructions except stores and conditional branches have 4:2 
      // not equal to zero
      rdWeDec		<= (iIbusData[4:2] != 3'b000) | (iIbusData[6:2] == 5'b00000);
      
      // select imm when instr[6:4] == 001
      // in rv32i, no other instruction has opcode[6:4] == 001 other than those
      // that use imm
      // lui also uses imm
      // jalr and jal also use imm
      immSelDec	<=  (iIbusData[6:4] == 3'b001) | 
                    (iIbusData[6:2] == 5'b01101) | 
                    (iIbusData[6:2] == 5'b11011) |
                    (iIbusData[6:2] == 5'b11001);

      // for the imm, use the opcode
      case (iIbusData[6:2]) // the last 2 bits are always 1 anyway
      
      // itype load
      5'b00000: immDec <= { {21{iIbusData[31]}}, iIbusData[30:20] };
      // itype alu
      5'b00100: immDec <= { {21{iIbusData[31]}}, iIbusData[30:20] };
      // jalr
      5'b11001: immDec <= { {21{iIbusData[31]}}, iIbusData[30:20] };
      
      // SType: store
      5'b01000: immDec <= { {21{iIbusData[31]}}, iIbusData[30:25], iIbusData[11:7] };

      // lui
      5'b01101: immDec <= { iIbusData[31:12], 12'b0 };
      // auipc
      5'b00101: immDec <= { iIbusData[31:12], 12'b0 };
      // jal
      5'b11011: immDec <= { {12{iIbusData[31]}}, iIbusData[19:12], iIbusData[20], iIbusData[30:25], iIbusData[24:21], 1'b0 };

      // btype, all conditional branches
      5'b11000: immDec <= { {20{iIbusData[31]}}, iIbusData[7], iIbusData[30:25], iIbusData[11:8], 1'b0 };

      endcase

      // load when all zero opcode
      lDec <= iIbusData[6:2] == 5'b00000;
      sDec <= iIbusData[6:2] == 5'b01000;

      // for now ignore the illegal instruction
      // TODO: add illegal indication
    end
  end

  // ===========================================================
  // fetch the operands from the register file
  // the register file has registered outputs

  // also maintain a RAT to track which registers are dirty
  // if dirty registers are needed, stall the previous stages
  // till clean value arrives and invalidate all the instructions
  // that are sent forward 

  reg [31:0]	registers [0:31];
  reg [31:0]	rs1Data, rs2Data, rdShiftEx;
  
  // data hazard handling mech
  reg [31:0]  rat [0:1];
  reg 				stallDataHazard;
  reg         falseAlarm;
  reg [1:0]   sourceEqual;

  reg 				validEx, rdWeEx;
	reg [2:0]   invalidRegister;

  integer idx;

  always @ (posedge clk or negedge rst_n) begin: RAT
    if (!rst_n) begin 
      rat[0] <= 'b0;
      rat[1] <= 'b0;
      falseAlarm <= 'b0;
      sourceEqual <= 'b0;
    end else if (!stallPipe) begin
      // update rat
      // set rd'th bit to 1 in rat[0..1]
      // if it is 1 then set it 1 anyway
      // set the rdEx'th bit to 0 in rat[0..1]
      // setting 1 takes priority

      // the zero register is always clean
      rat[0][0] <= 1'b0;
      rat[1][0] <= 1'b0;

      // on the condition that if rat[rd] is already 1 then 
      // 1. add x2, x1, x3
      // 2. add x2, x2, x4
      // when 1 is written back, rat[2] is set to 1 instead of 0
      // because 2 will force it
      // in this case, we must allow only 1 instruction to pass
      // we use a false alarm bit for this

      // raise false alarm when rdDec == rdEx and all the valid conditions
      // also set false alarm to zero if it is one
      if (falseAlarm) begin 
        falseAlarm <= 'b0;
        sourceEqual<= 'b0;
      end else if (rdWeDec && validDec && rdWeEx && validEx) begin 
        falseAlarm <= rdEx == rdDec;
        sourceEqual<= {(rs1Dec == rdEx), (rs2Dec == rdDec)};
      end

      for (idx = 1; idx < 32; idx = idx + 1) begin
        // there is also a false alarm when after a branch instruction is decoded,
        // another instruction sets the rat which is invalidated after the branch is taken
        // but the rat remains there and is not fixed

        // the code below fixes this by zeroing the rat set by the instructions currently in
        // of and dec
        if (branch) begin 
          if (rdOf == idx && validOf && rdWeOf) begin 
            // the possible instructions that set the rat are now in of
            // the instruction in dec can set the rat
            rat[0][idx] <= 1'b0;
            rat[1][idx] <= 1'b0;
          end 
          else if (rdDec == idx && validDec && rdWeDec) begin 
            rat[0][idx] <= 1'b0;
            rat[1][idx] <= 1'b0;
          end
          else if (rdEx == idx && validEx && rdWeEx) begin 
            rat[0][idx] <= 1'b0;
            rat[1][idx] <= 1'b0;
          end
        end 
        // if the register to be updated [(rdDecWe == 1) and (rdShiftDec[idx] == 1)]
        // then set the rat to 1 
        else if (rdWeDec && rdShiftDec[idx] && validDec && !dataHazard && !(|invalidRegister[1:0])) begin 
          rat[0][idx] <= 1'b1;
          rat[1][idx] <= 1'b1;
        end
        // else if the register is *being* updated [(rdExWe == 1) and (rdShiftEx[idx] == 1)]
        // then set the rat to 0
        else if (rdWeEx && rdShiftEx[idx] && validEx) begin 
          rat[0][idx] <= 1'b0;
          rat[1][idx] <= 1'b0;
        end			
      end
    end
  end

  // combinational part 
  reg rs1booked;
  reg rs2booked;
  always @ (*) begin: DATA_HAZARD_DETECTION
    // check if rs1 and rs2 are 'booked'
    // TODO: maybe take a look at this again
    // rs1 is booked if rat[0] is set and the instruction is not
    // lui, auipc
    rs1booked = |(rs1ShiftDec & rat[0]) && ~luipcDec;
    // rs2 is booked if rat[1] is set and the instruction is not 
    // one that uses imm
    rs2booked = |(rs2ShiftDec & rat[1]) && ~immSelDec;

    
    // data hazard occurs when rs1 or rs2 is booked and nothing is being written
    // to the regfile 
    // if there is data being written to the reg file then no need to stall, let it
    // pass
    dataHazard = falseAlarm ? (rs1booked & sourceEqual[1]) | (rs2booked & sourceEqual[0]) : ((rs1booked) | (rs2booked));
  end
  
  // when the data hazard occurs, set valid to zero and stall previous stages

  // propogate the rdWe, valid, aluOp, immSel, pc and imm signals
  reg [31:0]	immOf, pcOf;
  reg [3:0]		aluOpOf;
  reg 				lOf, sOf, luipcOf;
  reg         branchOf, compareOf;
  reg [31:0]	bTargetOf, branchOffset;

  always @ (posedge clk or negedge rst_n) begin: OF
    if (!rst_n) begin 
      {rs1Data, rs2Data, validOf, rdWeOf, immOf} <= 'b0;
      {pcOf, immSelOf, aluOpOf, rdOf, lOf, sOf, luipcOf, branchOf} <= 'b0;
      {compareOf, bTargetOf, branchOffset} <= 'b0;
      // !do not reset the registers!!

    end else if (!stallPipe) begin 
      // propogation
      {rdWeOf} <= {rdWeDec};
      {immSelOf, rdOf} <= {immSelDec, rdDec};
      {lOf, sOf, luipcOf} <= {lDec, sDec, luipcDec};

      // branch handles
      // branchOf signal is high when the branch is unconditional
      // e.g. jal, jalr
      branchOf <= branchDec & ~branchType;
      // compareOf is high when the branch is a conditional branch
      // e.g. bne, ...
      compareOf<= branchDec & branchType;
      
      bTargetOf<= jalr ? (rs1Dec == 5'b0 ? 32'b0 : registers [rs1Dec]) : pcDec;
      branchOffset <= immDec;

      if (falseAlarm) begin 
        validOf <= validDec & ~(branch | use2);
      end else begin 
        validOf <= validDec & ~dataHazard & ~(branch | use2);
      end 

      rs1Data <= rs1Dec == 5'b0 ? 32'b0 : registers [rs1Dec];
      rs2Data	<= rs2Dec == 5'b0 ? 32'b0 : registers [rs2Dec];
      aluOpOf <= luipcDec | (branchDec & ~branchType) ? 4'b0 : aluOpDec;
      pcOf    <= luiDec ? 32'b0 : pcDec;
      immOf   <= (branchDec & ~branchType) ? 32'd4 : immDec;
    end
  end

  // ============================================================
  // select the operands to feed the alu and lsu
  // add the imm in rs1 to get the address
  // the data to store is in rs2


  reg [31:0] 	aluIn1, aluIn2;

  // propogate the valid, aluOp, rdWe, pc
  reg [31:0] 	pcOs;
  reg [3:0]		aluOpOs;
  reg 				validOs, rdWeOs;
  reg [4:0]		rdOs;
  reg 				lOs, sOs;
  reg [31:0]	lsuAddrOs, lsuDataOs;
  
  // the branch compare signals
	reg					compareResult;
	
	
	// the branch comparators
	always @ (*) begin: BRANCH_COMPARATOR
    case (aluOpOf[2:0])
    3'b000: 	compareResult = rs1Data == rs2Data;
    3'b001: 	compareResult = rs1Data != rs2Data;
    3'b100: 	compareResult = $signed(rs1Data) <  $signed(rs2Data);
    3'b101: 	compareResult = $signed(rs1Data) >= $signed(rs2Data);
    3'b110: 	compareResult = rs1Data <  rs2Data;
    3'b111: 	compareResult = rs1Data >= rs2Data;
    default: compareResult = 1'b0;
    endcase
  end
	
	// the branch hazard handling technique
	// invalidate 3 instructions if the branch
	// is taken
	
	
	always @ (posedge clk or negedge rst_n) begin: BRANCH_HANDLER
    if (!rst_n) begin 
      invalidRegister <= 'b0;
    end else if (!stallPipe) begin 
      invalidRegister[0] <= ((compareResult & compareOf) | branchOf) & validOf;
      invalidRegister[1] <= invalidRegister[0];
      invalidRegister[2] <= invalidRegister[1];
    end
  end
	
  always @ (posedge clk or negedge rst_n) begin: OS
    if (!rst_n) begin 
      {pcOs, aluOpOs, validOs, rdWeOs, rdOs} <= 'b0;
      {aluIn1, aluIn2, lOs, sOs, lsuAddrOs, lsuDataOs} <= 'b0;
      {branch, branchTarget} <= 'b0;
    end else if (!stallPipe) begin 
      {pcOs, rdWeOs, rdOs} <= {pcOf, rdWeOf, rdOf};
      {lOs, sOs} <= {lOf, sOf};

      // the branch unit
      // branch only if instruction was unconditional branch
      // and if it was conditional then branch if the condition met
      
      branch <= (branchOf | (compareResult & compareOf)) & validOf & ~(branch | use2);
			branchTarget <= bTargetOf + branchOffset;
			validOs <= (|invalidRegister) ? 1'b0 : validOf;

      lsuAddrOs <= rs1Data + immOf;
      lsuDataOs <= rs2Data;

      // when lui comes, the imm is the value 
      // so zero aluIn1 and set operation to add
      aluIn1	<= (luipcOf | branchOf) ? pcOf : rs1Data;

      // aluIn2 is between imm and rs2Data
      aluIn2	<= immSelOf ? immOf : rs2Data;

      // if IType and the operation is add then clear op[3],
      // coz there is no subi 
      if (immSelOf && (aluOpOf[2:0] == 3'b000))
        aluOpOs[3] <= 1'b0;
      else 
        aluOpOs[3] <= aluOpOf[3];

      aluOpOs[2:0] <= aluOpOf[2:0]; 
    end
  end

  // ============================================================
  // the execute stage
  // can have multiple units in paralell
  // for now we only have the alu and lsu 
  reg [31:0] exRes;

  // propogate the valid, pc, rdWe
  reg [31:0]	pcEx;

  always @ (posedge clk or negedge rst_n) begin: EX
    if (!rst_n) begin 
      {pcEx, validEx, rdWeEx, rdEx, rdShiftEx} <= 'b0;
    end else if (!stallPipe) begin
      {pcEx, validEx, rdWeEx, rdEx} <= {pcOs, validOs, rdWeOs, rdOs};
      rdShiftEx <= 1 << rdOs;			
    end
  end

  // ============================================================
  // the alu has a fixed latency of 1
  // the alu causes no stalls
  reg [31:0]	aluRes;

  always @ (posedge clk or negedge rst_n) begin: EX_ALU
    if (!rst_n) begin 
      aluRes <= 'b0;
    end else begin 
      case (aluOpOs[2:0])
      3'b000: aluRes <= aluOpOs[3] ? aluIn1 - aluIn2 : aluIn1 + aluIn2;	// add/sub
      3'b001: aluRes <= aluIn1 << aluIn2[4:0];	// sll
      3'b010: aluRes <= $signed(aluIn1) < $signed(aluIn2) ? 32'b1 : 32'b0; 
      3'b011: aluRes <= aluIn1 < aluIn2 ? 32'b1 : 32'b0;
      3'b100: aluRes <= aluIn1 ^ aluIn2;
      3'b101: aluRes <= aluOpOs[3] ? $signed($signed(aluIn1) >>> aluIn2[4:0]) : aluIn1 >> aluIn2[4:0];
      3'b110: aluRes <= aluIn1 | aluIn2;
      3'b111: aluRes <= aluIn1 & aluIn2;
      endcase
    end 
  end

  // ============================================================
  // the lsu has min latency of 1 
  // max latency of infinity
  // lsu can stall the pipeline 
  // data to store in rs2

  reg [31:0]	lsuRes;
  reg 				lsuStall;
  reg [3:0]		lsuByteEn;
  reg 				lEx;

  assign oDbusAddr 		= lsuAddrOs;
  assign oDbusRead 		= lOs & validOs;
  assign oDbusWe	 		= sOs & validOs;
  assign oDbusData 		= lsuDataOs;
  assign oDbusByteEn 	= lsuByteEn;

  // wait only asserted when reading, writing does not assert wait
  // from m4k, reads have min latency of 1

  always @ (*) begin: EX_LSU_BYTEENABLE_GENERATOR
    lsuStall = iDbusWait & (lOs | sOs) & validOs;
  
    case (aluOpOs[1:0]) 
    2'b00:	lsuByteEn = 4'b1;			// sb/lb
    2'b01:	lsuByteEn = 4'b11;		// sh/lh
    2'b10:	lsuByteEn	= 4'b1111;	// sw/lw
    default:lsuByteEn = 4'b0;	
    endcase
  end

  always @ (posedge clk or negedge rst_n) begin: EX_LSU
    if (!rst_n) begin 
      lsuRes 	<= 'b0;
      lEx 		<= 'b0;
    end	else begin 
      lEx 		<= lOs;
      if (aluOpOs[1]) begin  // lw
        lsuRes <= iDbusData;
      end else begin 
        case ({aluOpOs[2], aluOpOs[0]}) 
        2'b00: lsuRes <= { {24{iDbusData[07]}}, iDbusData[07:0] };	// lb
        2'b01: lsuRes <= { {16{iDbusData[15]}}, iDbusData[15:0] };	// lh
        2'b10: lsuRes <= { 24'b0, iDbusData[07:0] };	// lbu
        2'b11: lsuRes <= { 16'b0, iDbusData[15:0] };	// lhu 
        endcase
      end
    end
  end

  // ============================================================
  // the stall handling mech,
  // simply or the stalls from all the sources
  // for now, only lsu can stall
  // IF doesn't stall, it keeps sending invalid instructions
  // which don't affect anything

  always @ (*) begin: EX_LSU_STALL_GENERATOR
    stallPipe = lsuStall;
  end	

  // ============================================================
  // the write back stage

  // mux the result from various stages
  // for now, if load instruction, then select lsuRes
  always @ (*) begin: WB_MUX
    exRes	= lEx ? lsuRes : aluRes;
  end

  always @ (posedge clk) begin: WB_REGISTER_FILE
    // do not reset the register file
    // write back if valid only
    if (validEx && (rdWeEx | lEx)) begin 
      registers[rdEx] <= exRes;
    end
  end
endmodule 
