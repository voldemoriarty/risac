// the csr's are special registers that 
// are accessed via special instructions
// 
// for rv32i, the following csrs are required
// =====		=====		=======================
// cycle		64bit		counts number of cycles
// time			64bit		counts time, marzi ki frequency
// instret	64bit		counts number of instructions retired

// the addresses or csr numbers of the registers are

// =====		=====		=====
// cycle		31:00		0xc00
// 					63:32		0xc80
// time			31:00		0xc01
// 					63:32		0xc81
// instret	31:00		0xc02
//					63:32		0xc82

// the operations required on csr's are 
// csr = [rs1]; 		out = csr			(if rd = x0, then it shall not read)
// csr = set[rs1]; 	out = csr			(if rs1= x0, then it shall not write)
// csr = clr[rs1];	out = csr			(if rs1= x0, then it shall not write)

module csr_unit (
	input		clk,
	input		rst_n,

	input		read,
	input		[11:0] addr,
	input		write,
	input		clr,
	input		set,
	input		[31:0] wdata,

	// csr specific line
	input		time_clk,
	input		ins_ret,

	output	reg [31:0] rdata
);

	localparam 
		CYCLEL 	= 12'hc00,
		CYCLEH 	= 12'hc80,
		TIMEL		= 12'hc01,
		TIMEH		= 12'hc81,
		INSL		= 12'hc02,
		INSH		= 12'hc82;

	// create registers for the 3 csrs required in rv32i
	wire [63:0] csr_time, csr_cycle, csr_instret;

	// enables corresponding to different csrs
	wire time_en_l		= addr == TIMEL;
	wire time_en_h		= addr == TIMEH;
	wire cycle_en_l		= addr == CYCLEL;
	wire cycle_en_h		= addr == CYCLEH;
	wire instr_en_l		= addr == INSL;
	wire instr_en_h		= addr == INSH;

	wire time_write_l 	= write & time_en_l;
	wire time_write_h		= write & time_en_h;
	wire cycle_write_l	= write & cycle_en_l;
	wire cycle_write_h	= write & cycle_en_h;
	wire instr_write_l	= write & instr_en_l;
	wire instr_write_h	= write & instr_en_h;

	wire time_set_l 	= set & time_en_l;
	wire time_set_h		= set & time_en_h;
	wire cycle_set_l	= set & cycle_en_l;
	wire cycle_set_h	= set & cycle_en_h;
	wire instr_set_l	= set & instr_en_l;
	wire instr_set_h	= set & instr_en_h;

	wire time_clr_l 	= clr & time_en_l;
	wire time_clr_h		= clr & time_en_h;
	wire cycle_clr_l	= clr & cycle_en_l;
	wire cycle_clr_h	= clr & cycle_en_h;
	wire instr_clr_l	= clr & instr_en_l;
	wire instr_clr_h	= clr & instr_en_h;

	// the cycle counter just counts to infinity and beyond
	csr_register cycle_csr (
  	.clk (clk),
		.rst_n(rst_n),

		.write_l(cycle_write_l),
		.write_h(cycle_write_h),
		.clr_l(cycle_clr_l),
		.clr_h(cycle_clr_h),
		.set_l(cycle_set_l),
		.set_h(cycle_set_h),
		.wdata(wdata),
		.update(csr_cycle + 1'b1),
		.csr(csr_cycle)
	);

	// time csr count the edges in timeclk

	reg time_clk_old;

	always @ (posedge clk or negedge rst_n) begin 
		if (!rst_n) begin 
			time_clk_old <= 'b0;
		end else begin 
			time_clk_old <= time_clk;
		end
	end

	// 0 -> 1 edge detector
	wire time_clk_edge = time_clk & ~time_clk_old;

	csr_register time_csr (
  	.clk (clk),
		.rst_n(rst_n),

		.write_l(time_write_l),
		.write_h(time_write_h),
		.clr_l(time_clr_l),
		.clr_h(time_clr_h),
		.set_l(time_set_l),
		.set_h(time_set_h),
		.wdata(wdata),
		.update(csr_time + time_clk_edge),
		.csr(csr_time)
	);

	csr_register instret_csr (
  	.clk (clk),
		.rst_n(rst_n),

		.write_l(instr_write_l),
		.write_h(instr_write_h),
		.clr_l(instr_clr_l),
		.clr_h(instr_clr_h),
		.set_l(instr_set_l),
		.set_h(instr_set_h),
		.wdata(wdata),
		.update(csr_instret + ins_ret),
		.csr(csr_instret)
	);

	// the output read mux
	always @ (posedge clk or negedge rst_n) begin : OUT_MUX
		if (!rst_n) begin 
			rdata <= 1'b0;
		end else begin 
			case (addr) 
			CYCLEL:	rdata <= csr_cycle[31:00];
			CYCLEH:	rdata <= csr_cycle[63:32];
			TIMEL:	rdata <= csr_time[31:00];
			TIMEH:	rdata <= csr_time[63:32];
			INSL:		rdata	<= csr_instret[31:00];
			INSH:		rdata <= csr_instret[63:32];
			endcase
		end
	end

endmodule 

module csr_register (
	input		clk,
	input		rst_n,

	input		write_l,
	input		write_h,
	input		clr_l,
	input		clr_h,
	input		set_l,
	input		set_h,

	input		[31:0] wdata,
	input		[63:0] update,

	output	reg [63:0] csr
);

	always @ (posedge clk or negedge rst_n) begin: CSR 
		if (!rst_n) begin 
			csr <= 'b0;
		end else if (write_l) begin 
			csr[31:00] <= wdata;
		end else if (write_h) begin 
			csr[63:32] <= wdata;
		end else if (clr_l) begin 
			csr[31:00] <= csr[31:00] & ~wdata;
		end else if (clr_h) begin 
			csr[63:32] <= csr[63:32] & ~wdata;
		end else if (set_l) begin 
			csr[31:00] <= csr[31:00] | wdata;
		end else if (set_h) begin 
			csr[63:32] <= csr[63:32] | wdata;
		end else begin 
			csr <= update;
		end
	end
endmodule 