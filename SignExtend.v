/**************************************************************************************************/
/**************************************************************************************************/
/*****************************		Author: Alyaa Mohamed 	***************************************/
/*****************************		Module: Sign Extend   	***************************************/
/**************************************************************************************************/
/**************************************************************************************************/

module SignExtend
(

	input 	wire 	[15:0] Inst		,
	output 	reg 	[31:0] imm 

);

	reg [15:0] a = 16'b0			;
	reg [15:0] b = 16'hffff			;

/***************************************************************************************************/
/***************************************************************************************************/

	always @(*)
		begin
			
			if (Inst[15]==1)
				
					imm= {b,Inst}	;
				
			else 
				
					imm= {a,Inst}	;
				
		
		end

endmodule