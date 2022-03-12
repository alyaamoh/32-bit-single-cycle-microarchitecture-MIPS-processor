/**************************************************************************************************/
/**************************************************************************************************/
/*****************************		Author: Alyaa Mohamed 	   ************************************/
/*****************************		Module: Instruction Memory ************************************/
/**************************************************************************************************/
/**************************************************************************************************/

module Inst_Mem 
(

	input 	wire [31:0] PC								,

	output 	wire [31:0] Instr

);

/***************************************************************************************************/
/***************************************************************************************************/

	reg 		 [31:0] ROM 	[99:0]					;

/***************************************************************************************************/
/***************************************************************************************************/

	initial $readmemh("Program 1_Machine Code.txt",ROM) ;

/***************************************************************************************************/
/***************************************************************************************************/

	assign Instr = ROM[PC >> 2'd2]						;

endmodule