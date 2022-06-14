module SignExtend(Out, In);
	input 	[4:0] 	In;
	output 	[15:0] 	Out;
	
	assign Out = In[4] ? {11'b11111111111, In}:{11'b00000000000, In};
	
endmodule
