
module Datapath (CLK, PCSrc, RegSrc, RegWrEn, ALUSrc, ALUopcode, DmemWrEn, WrSrc, INST, Zero, PC,
				REG0, REG1, REG2, REG3, REG4, REG5, REG6, REG7, ALU_result, outDMEM, ALU_A, ALU_B
				);
	input			CLK, PCSrc, RegSrc, RegWrEn, ALUSrc, DmemWrEn, WrSrc;
	input 	[2:0]	ALUopcode;
	output	[5:0]	PC;
	output 	[15:0]	REG0, REG1, REG2, REG3, REG4, REG5, REG6, REG7;
	output	[15:0]	ALU_result, outDMEM;
	output	[4:0]	INST;
	output			Zero;
	output	[15:0]	ALU_A, ALU_B;
	
	wire	[15:0]	instruction;
	wire 	[4:0]	PCout;
	
	//tu trai sang phai
	//mux thu nhat
	wire	[4:0]	pc0, pc1, muxPC;
	//mux thu hai
	wire	[2:0]	muxRegFile;
	//reg file
	wire	[15:0]	A, B;
	//mux thu ba
	wire	[15:0]	kq_signExtend, muxALU;
	//alu
	wire	[15:0]	outALU;
	//DMEM
	wire	[15:0]	outDMEM;
	//mux thu tu
	wire	[15:0]	muxDataWr;
	
	mux2 #(.n(5)) inst0(.Select(PCSrc), .InA(pc0), .InB(pc1), .Out(muxPC));
	PC inst1(.CLK(CLK), .In(muxPC), .PC(PCout));
	add inst2(.InA(5'd1), .InB(PCout), .Out(pc0));
	IMEM inst3(.addr(PCout), .q(instruction));
	add inst4(.InA(instruction[4:0]), .InB(PCout), .Out(pc1));
	assign PC = PCout << 1;
	assign INST = instruction[15:11];
	mux2 #(.n(3)) inst5(.Select(RegSrc), .InA(instruction[10:8]), .InB(instruction[4:2]), .Out(muxRegFile));
	RegFile inst6 (	.ReadData1(A), 
					.ReadData2(B),
					.REG0(REG0),
					.REG1(REG1),
					.REG2(REG2),
					.REG3(REG3),
					.REG4(REG4),
					.REG5(REG5),
					.REG6(REG6),
					.REG7(REG7),
					.WriteData(muxDataWr), 
					.ReadWriteEn(RegWrEn), 
					.WriteAddress(instruction[10:8]), 
					.ReadAddress1(instruction[7:5]), 
					.ReadAddress2(muxRegFile), 
					.CLK(CLK));
	SignExtend inst7(.In(instruction[4:0]), .Out(kq_signExtend));
	mux2 #(.n(16)) inst8(.Select(ALUSrc), .InA(B), .InB(kq_signExtend), .Out(muxALU));
	ALU inst9(.InA(A), .InB(muxALU), .ALU_opcode(ALUopcode), .Out(outALU), .Zero(Zero));
	DMEM inst10(.ReadData(outDMEM), .Address(outALU), .WriteData(B), .WriteEn(DmemWrEn), .CLK(CLK));
	mux2 #(.n(16)) inst11(.Select(WrSrc), .InA(outDMEM), .InB(outALU), .Out(muxDataWr));
	assign ALU_result = outALU;
	assign ALU_A = A;
	assign ALU_B = muxALU;
	
endmodule
