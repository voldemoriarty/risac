// simple mm timer
// counts one every cycle
// 
// memory map
// 0		low 	31:00
// 1		high	63:32


module timer (
	input	 	clk,
	input  	rst_n,
	
	// av-mm interface
	input		addr,
	input		read,
	input		write,
	input		[31:0] writedata,

	output	reg [31:0] readdata
);

	reg [63:0] count;

	always @ (posedge clk or negedge rst_n) begin 
		if (!rst_n) begin 
			count <= 'b0;
		end else if (write) begin 
			if (addr) 
				count[63:32] <= writedata;
			else 
				count[31:00] <= writedata;
		end else begin 
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
			endcase
		end
	end
endmodule 