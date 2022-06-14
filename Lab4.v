
module Lab4(CLK, PC, REG0, REG1, REG2, REG3, REG4, REG5, REG6, REG7, 
		inst_opcode, ALUopcode, ALU_result, Zero, outDMEM, ALU_A, ALU_B);
	input	CLK;
	output 		[5:0]	PC;
	output 		[15:0]	REG0, REG1, REG2, REG3, REG4, REG5, REG6, REG7;
	output 		[4:0]	inst_opcode;
	output 		[2:0]	ALUopcode;
	output 		[15:0]	ALU_result, outDMEM, ALU_A, ALU_B;
	output				Zero;
	
	wire 				PCSrc, RegSrc, RegWrEn, ALUSrc, DmemWrEn, WrSrc;
	
	
	Control c(.PCSrc(PCSrc), .RegSrc(RegSrc), 
			.RegWrEn(RegWrEn), .ALUSrc(ALUSrc), 
			.ALUopcode(ALUopcode), 
			.DmemWrEn(DmemWrEn), .WrSrc(WrSrc), 
			.INST(inst_opcode), .z(Zero));
			
	Datapath d(	.CLK(CLK), .PCSrc(PCSrc), .RegSrc(RegSrc), 
				.RegWrEn(RegWrEn), .ALUSrc(ALUSrc), 
				.ALUopcode(ALUopcode), .DmemWrEn(DmemWrEn), 
				.WrSrc(WrSrc), .INST(inst_opcode), .Zero(Zero), .PC(PC),
				.REG0(REG0), .REG1(REG1), .REG2(REG2), .REG3(REG3), 
				.REG4(REG4), .REG5(REG5), .REG6(REG6), .REG7(REG7), .ALU_result(ALU_result),
				.outDMEM(outDMEM), .ALU_A(ALU_A), .ALU_B(ALU_B)
				);
endmodule
