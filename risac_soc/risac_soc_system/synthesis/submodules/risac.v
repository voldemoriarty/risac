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
	reg [31:0]	pc;
	reg dataHazard;
	reg stallPipe;
	reg readIbus;
	
	assign oIbusAddr = pc;
	assign oIbusRead = !stallPipe && !dataHazard;

	// read signal must always be asserted regardless of 
	// wait

	always @ (posedge clk or negedge rst_n) begin 
		if (!rst_n) begin 
			pc <= 'b0;
			readIbus <= 'b1;
		end	else if (!stallPipe && !dataHazard) begin 
			// new data arrives when wait is 0
			// so update pc when wait is 0
			pc <= iIbusWait ? pc : pc + 3'd4;

			// assert read regardless of wait
			// but only when pc is updated
			readIbus <= iIbusWait ? 1'b0 : 1'b1;
		end else begin
			readIbus <= 1'b0;
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
	reg					lDec, sDec;

	always @ (posedge clk or negedge rst_n) begin 
		if (!rst_n) begin 
			{aluOpDec, rs1Dec, rs2Dec, immDec, validDec, immSelDec, rdShiftDec} <= 'b0;
			{rdWeDec, illegalDec, pcDec, lDec, sDec, rs1ShiftDec, rs2ShiftDec} <= 'b0;
		end else if (!stallPipe && !dataHazard) begin 
			// the address of the currently being decoded instruction
			pcDec			<= iIbusIAddr;

			// the instruction is valid if there is not wait signal
			validDec	<= ~iIbusWait;

			// decode the instruction regardless of validity
			
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

			// always write to rd except when storing or branching
			// we cater only stores for now 
			rdWeDec		<= iIbusData[6:0] != 7'b0100011;
			
			// select imm when instr[6:4] == 001
			// in rv32i, no other instruction has opcode[6:4] == 001 other than those
			// that use imm
			immSelDec	<= (iIbusData[6:4] == 3'b001);

			// for the imm, use the opcode
			case (iIbusData[6:2]) // the last 2 bits are always 1 anyway
			
			// itype load
			5'b00000: immDec <= { {21{iIbusData[31]}}, iIbusData[30:20] };
			// itype alu
			5'b00100: immDec <= { {21{iIbusData[31]}}, iIbusData[30:20] };
			//jalr
			5'b11001: immDec <= { {21{iIbusData[31]}}, iIbusData[30:20] };
			
			// SType: store
			5'b01000: immDec <= { {21{iIbusData[31]}}, iIbusData[30:25], iIbusData[11:7] };

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

	reg 				validEx, rdWeEx;

	integer idx;

	always @ (posedge clk or negedge rst_n) begin: RAT
		if (!rst_n) begin 
			rat[0] <= 'b0;
			rat[1] <= 'b0;
		end else if (!stallPipe) begin
			// update rat
			// set rd'th bit to 1 in rat[0..1]
			// if it is 1 then set it 1 anyway
			// set the rdEx'th bit to 0 in rat[0..1]
			// setting 1 takes priority

			// the zero register is always clean
			rat[0][0] <= 1'b0;
			rat[1][0] <= 1'b0;

			for (idx = 1; idx < 32; idx = idx + 1) begin
				// if the register to be updated [(rdDecWe == 1) and (rdShiftDec[idx] == 1)]
				// then set the rat to 1 
				if (rdWeDec && rdShiftDec[idx] && validDec) begin 
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
	always @ (*) begin 
		// check if rs1 and rs2 are 'booked'
		rs1booked = |(rs1ShiftDec & rat[0]);
		rs2booked = |(rs2ShiftDec & rat[1]) && ~immSelDec;

		// rs1booked = rat[0][rs1Dec];
		// rs2booked = rat[1][rs2Dec] && ~immSelDec;
		dataHazard = rs1booked | rs2booked;
	end
	
	// when the data hazard occurs, set valid to zero and stall previous stages

	// propogate the rdWe, valid, aluOp, immSel, pc and imm signals
	reg					validOf, rdWeOf, immSelOf;	
	reg [31:0]	immOf, pcOf;
	reg [3:0]		aluOpOf;
	reg [4:0]		rdOf;
	reg 				lOf, sOf;

	always @ (posedge clk or negedge rst_n) begin 
		if (!rst_n) begin 
			{rs1Data, rs2Data, validOf, rdWeOf, immOf} <= 'b0;
			{pcOf, immSelOf, aluOpOf, rdOf, lOf, sOf} <= 'b0;
			// !do not reset the registers!!

		end else if (!stallPipe) begin 
			// propogation
			{validOf, rdWeOf, immOf} <= {validDec & ~dataHazard, rdWeDec, immDec};
			{pcOf, immSelOf, aluOpOf, rdOf} <= {pcDec, immSelDec, aluOpDec, rdDec};
			{lOf, sOf} <= {lDec, sDec};

			rs1Data <= rs1Dec == 5'b0 ? 32'b0 : registers [rs1Dec];
			rs2Data	<= rs2Dec == 5'b0 ? 32'b0 : registers [rs2Dec];
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

	always @ (posedge clk or negedge rst_n) begin 
		if (!rst_n) begin 
			{pcOs, aluOpOs, validOs, rdWeOs, rdOs} <= 'b0;
			{aluIn1, aluIn2, lOs, sOs, lsuAddrOs, lsuDataOs} <= 'b0;
		end else if (!stallPipe) begin 
			{pcOs, validOs, rdWeOs, rdOs} <= {pcOf, validOf, rdWeOf, rdOf};
			{lOs, sOs} <= {lOf, sOf};

			lsuAddrOs <= rs1Data + immOf;
			lsuDataOs <= rs2Data;

			// for now aluIn1 is just rs1Data
			aluIn1	<= rs1Data;

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
	reg [4:0]		rdEx;

	always @ (posedge clk or negedge rst_n) begin 
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

	always @ (posedge clk or negedge rst_n) begin 
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

	always @ (*) begin 
		lsuStall = iDbusWait & (lOs | sOs) & validOs;
	
		case (aluOpOs[1:0]) 
		2'b00:	lsuByteEn = 4'b1;			// sb/lb
		2'b01:	lsuByteEn = 4'b11;		// sh/lh
		2'b10:	lsuByteEn	= 4'b1111;	// sw/lw
		default:lsuByteEn = 4'b0;	
		endcase
	end

	always @ (posedge clk or negedge rst_n) begin 
		if (!rst_n) begin 
			lsuRes 	<= 'b0;
			lEx 		<= 'b0;
		end	else if (!stallPipe) begin 
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

	always @ (*) begin 
		stallPipe = lsuStall;
	end	

	// ============================================================
	// the write back stage

	// mux the result from various stages
	// for now, if load instruction, then select lsuRes
	always @ (*) begin 
		exRes	= lEx ? lsuRes : aluRes;
	end

	always @ (posedge clk) begin 
		// do not reset the register file
		// write back if valid only
		if (validEx && rdWeEx) begin 
			registers[rdEx] <= exRes;
		end
	end
endmodule 