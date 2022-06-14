
module DMEM(ReadData, Address, WriteData, WriteEn, CLK);
	input 				CLK, WriteEn;
	input 		[15:0] 	Address, WriteData;
	output reg 	[15:0] 	ReadData;
	
	reg [15:0] array_reg [15:0];
	
	always @ (posedge CLK)begin
		if (WriteEn) begin
			array_reg[Address] = WriteData;
			ReadData = array_reg[Address];
		end
		else
			ReadData = array_reg[Address];
	end
endmodule
