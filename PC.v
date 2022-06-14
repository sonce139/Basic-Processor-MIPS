
module PC(PC, In, CLK);
	input		[4:0] 	In;
	input 				CLK;
	output reg	[4:0] 	PC;
	
	initial PC = 5'd0;
	
	always @(posedge CLK) begin
		PC = In;
	end
	
endmodule
