
`timescale 1ns/1ps

module tesbenchLab4();
	reg	CLK;
	wire [5:0]	PC;
	wire [15:0]	REG0, REG1, REG2, REG3, REG4, REG5, REG6, REG7;
	wire [4:0]	inst_opcode;
	wire [15:0]	ALU_result;
	wire [2:0]	ALUopcode;
	wire 		Zero;
	
	parameter t = 50;
	
	initial begin
		CLK = 1'b0;
		#(32*t) $finish;
	end
	
	always #(t/2) CLK = ~CLK;	
	
	Lab4 lab04(	.CLK(CLK), 
				.PC(PC), 
				.REG0(REG0), 
				.REG1(REG1), 
				.REG2(REG2), 
				.REG3(REG3), 
				.REG4(REG4), 
				.REG5(REG5), 
				.REG6(REG6), 
				.REG7(REG7), 
				.inst_opcode(inst_opcode), 
				.ALU_result(ALU_result), 
				.ALUopcode(ALUopcode),
				.Zero(Zero)
	);
	
endmodule
