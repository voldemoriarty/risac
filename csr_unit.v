// the csr's are special registers that 
// are accessed via special instructions


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
	input		[31:0] mepc,
	input 	timer_overflow,

	output	[31:0] mtvec,
	output	[31:0] mie,
	output 	[31:0] mip,

	output	reg [31:0] rdata
);

	localparam 
		MEPC 		= 12'h341,	// 32
		MCAUSE 	= 12'h342,	// 32
		MTVEC		= 12'h305,	// 32
		MIE			= 12'h304,	// 32 
		MIP			= 12'h344;	// 32
	
	wire mepc_en 		= addr == MEPC;
	wire mcause_en	= addr == MCAUSE;
	wire mtvec_en		= addr == MTVEC;
	wire mie_en			= addr == MIE;
	wire mip_en			= addr == MIP;

	wire [31:0] _mepc, _mcause, _mtvec, _mie, _mip;

	assign mtvec = _mtvec;
	assign mie = _mie;
	assign mip = _mip;

	csr_register_32 csr_mepc (
		.clk       (clk),
		.rst_n     (rst_n),
		.write     (write & mepc_en),
		.clr       (clr & mepc_en),
		.set       (set & mepc_en),
		.wdata     (wdata),
		.update    (mepc),
		.csr       (_mepc)
	);

	csr_register_32 csr_mcause (
		.clk       (clk),
		.rst_n     (rst_n),
		.write     (write & mcause_en),
		.clr       (clr & mcause_en),
		.set       (set & mcause_en),
		.wdata     (wdata),
		.update    (timer_overflow ? {1'b1, 31'd7} : 32'd0),
		.csr       (_mcause)
	);

	csr_register_32 csr_mtvec (
		.clk       (clk),
		.rst_n     (rst_n),
		.write     (write & mtvec_en),
		.clr       (clr & mtvec_en),
		.set       (set & mtvec_en),
		.wdata     (wdata),
		.update    (_mtvec),
		.csr       (_mtvec)
	);

	csr_register_32 csr_mie (
		.clk       (clk),
		.rst_n     (rst_n),
		.write     (write & mie_en),
		.clr       (clr & mie_en),
		.set       (set & mie_en),
		.wdata     (wdata),
		.update    (_mie),
		.csr       (_mie)
	);

	csr_register_32 csr_mip (
		.clk       (clk),
		.rst_n     (rst_n),
		.write     (write & mip_en),
		.clr       (clr & mip_en),
		.set       (set & mip_en),
		.wdata     (wdata),
		.update    ({24'b0 ,timer_overflow, 7'b0}),
		.csr       (_mip)
	);
	// the output read mux
	always @ (posedge clk or negedge rst_n) begin : OUT_MUX
		if (!rst_n) begin 
			rdata <= 1'b0;
		end else begin 
			case (addr) 
			MEPC:		rdata <= _mepc;
			MCAUSE:	rdata <= _mcause;
			MTVEC:	rdata <= _mtvec;
			MIE:		rdata <= _mie;
			MIP:		rdata	<= _mip;
			endcase
		end
	end

endmodule 

module csr_register_32 (
	input		clk,
	input		rst_n,

	input		write,
	input		clr,
	input		set,

	input		[31:0] wdata,
	input		[31:0] update,

	output	reg [31:0] csr
);

	always @ (posedge clk or negedge rst_n) begin: CSR 
		if (!rst_n) begin 
			csr <= 'b0;
		end else if (write) begin 
			csr <= wdata;
		end else if (clr) begin 
			csr <= csr & ~wdata;
		end else if (set) begin 
			csr <= csr | wdata;
		end else begin 
			csr <= update;
		end
	end
endmodule 