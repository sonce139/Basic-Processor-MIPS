
module Control(PCSrc, RegSrc, RegWrEn, ALUSrc, ALUopcode, DmemWrEn, WrSrc, INST, z);
	input				z;
	input		[4:0] 	INST;
	output reg	[2:0] 	ALUopcode;
	output reg 			PCSrc, RegSrc, RegWrEn, ALUSrc, DmemWrEn, WrSrc;
	
	always @(*) begin			
		if(INST[4] == 1'b0) begin		// for R-type 
			PCSrc = 1'b0;
			RegSrc = 1'b1;
			RegWrEn = 1'b1;
			ALUSrc = 1'b0; 				
			DmemWrEn = 1'b0;
			WrSrc = 1'b1;
		
			if(INST[3:0] == 4'b0010) ALUopcode = 3'd0; 	// Add
			if(INST[3:0] == 4'b0011) ALUopcode = 3'd1;	// Sub
			if(INST[3:0] == 4'b0100) ALUopcode = 3'd2;	// And
			if(INST[3:0] == 4'b0101) ALUopcode = 3'd3;	// Or
			if(INST[3:0] == 4'b0110) ALUopcode = 3'd4;	// Xor
			if(INST[3:0] == 4'b1000) ALUopcode = 3'd5; 	// dich phai
			if(INST[3:0] == 4'b1001) ALUopcode = 3'd6;	// dich phai so hoc
			if(INST[3:0] == 4'b1010) ALUopcode = 3'd7;	// dich trai
		end
		
		else if(INST[4] == 1'd1) begin
			if(INST[3] == 1'b0) begin 			// for I type
				PCSrc = 1'b0;
				RegSrc = 1'b1;
				RegWrEn = 1'b1;
				ALUSrc = 1'b1;
				DmemWrEn = 1'b0;
				WrSrc = 1'b1;
			
				if(INST[2:0] == 3'b010) ALUopcode = 3'd0; 	// Add
				if(INST[2:0] == 3'b100) ALUopcode = 3'd2;	// And
				if(INST[2:0] == 3'b101) ALUopcode = 3'd3;	// Or
				if(INST[2:0] == 3'b110) ALUopcode = 3'd4;	// Xor
			end
			else if (INST[3] == 1'b1) begin
				if (INST[3:0] == 4'b1100) begin    //lenh nap - lw
					PCSrc = 1'b0;
					RegSrc = 1'b0;
					RegWrEn = 1'b1;
					ALUSrc = 1'b1;
					DmemWrEn = 1'b1;
					WrSrc = 1'b0;
					ALUopcode = 3'd0; 	// Add
				end
				else if (INST[3:0] == 4'b1101) begin    //lenh luu - sw
					PCSrc = 1'b0;
					RegSrc = 1'b0;
					RegWrEn = 1'b0;
					ALUSrc = 1'b1;
					DmemWrEn = 1'b1;
					WrSrc = 1'b0;
					ALUopcode = 3'd0; 	// Add
				end
				else if (INST[3:0] == 4'b1110) begin    //lenh beq
					RegSrc = 1'b0;
					RegWrEn = 1'b0;
					ALUSrc = 1'b0;
					DmemWrEn = 1'b0;
					WrSrc = 1'b1;
					ALUopcode = 3'd1; 	// sub
					if(z == 1'b1)
						PCSrc = 1'b1;
					else	
						PCSrc = 1'b0;
				end
				else if (INST[3:0] == 4'b1111) begin    //lenh bne
					RegSrc = 1'b0;
					RegWrEn = 1'b0;
					ALUSrc = 1'b0;
					DmemWrEn = 1'b0;
					WrSrc = 1'b1;
					ALUopcode = 3'd1; 	// sub
					if(z == 1'b1)
						PCSrc = 1'b0;
					else	
						PCSrc = 1'b1;
				end
			end
		end
	end
	
endmodule
