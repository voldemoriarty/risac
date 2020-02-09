// simple mm timer with cmp
// counts one every cycle

// stops counting when count becomes equal to
// cmp register and raises the overflow line
// will resume count if cmp or count is rewritten and 
// count < cmp

// memory map
// 0		low 	31:00
// 1		high	63:32
// 2		clow	31:00
// 3		chigh	63:32


module timer (
	input	 	clk,
	input  	rst_n,
	
	// av-mm interface
	input		[01:00] addr,
	input		read,
	input		write,
	input		[31:0] writedata,
	output	reg [31:0] readdata,
	output	timer_overflow
);

	reg [63:0] count, cmp;

	assign timer_overflow = (count >= cmp);

	always @ (posedge clk or negedge rst_n) begin 
		if (!rst_n) begin 
			count <= 'b0;
			cmp <= 64'hffffffffffffffff;
		end else if (write) begin 
			case (addr) 
			0: count[31:00] <= writedata;
			1: count[63:32] <= writedata;
			2: cmp[31:00] <= writedata;
			3: cmp[63:32] <= writedata;
			endcase
		end else if (!timer_overflow) begin 
			count <= count + 1'b1;
		end
	end


	always @ (posedge clk or negedge rst_n) begin 
		if (!rst_n) begin
			readdata <= 'b0; 
		end else if (read) begin 
			case (addr)
			0: readdata <= count[31:00];
			1: readdata <= count[63:32];
			2: readdata <= cmp[31:00];
			3: readdata <= cmp[63:32]; 
			endcase
		end
	end
endmodule 