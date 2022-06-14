
module RegFile(	ReadData1, 
				ReadData2,
				REG0,
				REG1,
				REG2,
				REG3,
				REG4,
				REG5,
				REG6,
				REG7,
				WriteData, 
				ReadWriteEn, 
				WriteAddress, 
				ReadAddress1, 
				ReadAddress2, 
				CLK);
	input 			ReadWriteEn, CLK;	
	input	[2:0] 	WriteAddress, ReadAddress1, ReadAddress2;
	input	[15:0] 	WriteData;
	output 	[15:0] 	ReadData1, ReadData2;
	output	[15:0] 	REG0, REG1, REG2, REG3, REG4, REG5, REG6, REG7;
	
	reg 	[15:0] array_reg [7:0];
	reg 	[15:0] reg1, reg2;
	integer i;
	
	initial begin
		for (i=0; i<8; i=i+1)
			array_reg[i] = 16'd0;
	end
	
	always @(posedge CLK) begin
		//Write to register file: ReadWriteEn == 1		
		if(ReadWriteEn) begin
			if (WriteAddress != 3'd0)
				array_reg[WriteAddress] = WriteData;	
		end
	end
		//Read from register file
	always @(ReadAddress1 or ReadAddress2) begin 
			reg1 = array_reg[ReadAddress1];
			reg2 = array_reg[ReadAddress2];
	end	
	
	assign REG0 = array_reg[0];
	assign REG1 = array_reg[1];
	assign REG2 = array_reg[2];
	assign REG3 = array_reg[3];
	assign REG4 = array_reg[4];
	assign REG5 = array_reg[5];
	assign REG6 = array_reg[6];
	assign REG7 = array_reg[7];
	assign ReadData1 = reg1;
	assign ReadData2 = reg2;
	
endmodule
