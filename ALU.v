
module ALU (Out, Zero, InA, InB, ALU_opcode);
	input signed		[15:0]	InA, InB;
	input				[2:0]	ALU_opcode;
	output reg signed	[15:0]	Out;
	output reg					Zero;
	
	always @(*) begin
		case (ALU_opcode)
			3'd0:	Out = InA + InB;
			3'd1:	Out = InA - InB;
			3'd2:	Out = InA & InB;
			3'd3:	Out = InA | InB;
			3'd4:	Out = InA ^ InB;
			3'd5:	Out = InA >> InB[2:0];
			3'd6:	Out = InA >>> InB[2:0];
			3'd7:	Out = InA << InB[2:0];
		endcase
		Zero = (Out == 16'd0) ? 1'b1 : 1'b0;
	end

endmodule
