module timer (
	input	 clk,
	input  rst_n,
	
	input  load,
	input  [63:0] loadData,
	output reg [63:0] count 
);

	always @ (posedge clk or negedge rst_n) begin 
		if (!rst_n) begin 
			count <= 'b0;
		end else if (load) begin 
			count <= loadData;
		end else begin 
			count <= count + 1'b1;
		end
	end

endmodule 