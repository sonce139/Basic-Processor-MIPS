
module add(Out, InA, InB);
	input 		[4:0] InA, InB;
	output reg	[4:0] Out;
	
	always @(*) begin
		Out = InA + InB;
	end
	
endmodule