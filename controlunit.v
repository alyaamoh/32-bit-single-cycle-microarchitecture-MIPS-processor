/**************************************************************************************************/
/**************************************************************************************************/
/*****************************		Author: Alyaa Mohamed 	***************************************/
/*****************************		Module: control unit	***************************************/
/**************************************************************************************************/
/**************************************************************************************************/

module controlunit
(
    input  wire	[5:0] 	funct											,
    input  wire	[5:0] 	opcode											,
	
	output reg 			jump											,
    output reg 			memtoreg										,
    output reg 			memwrite										,
    output reg 			branch											,
    output reg 			alusrc											,
    output reg 			regdst											,
    output reg 			regwrite										,
    output reg 	[2:0] 	ALUControl 									
);									

/*****************************	     Internal signal         ***************************************/

	reg 		[1:0] 	ALUOP											;
	
/***************************************************************************************************/
/*****************************	       Main Decoder          ***************************************/	
						
	 always @(*)							
		 begin							
									
			  memtoreg = 0												;
			  memwrite = 0												;
			  branch   = 0												;
			  alusrc   = 0												;
			  regdst   = 0												;
			  regwrite = 0												;
			  jump     = 0												;
			  ALUOP    = 2'b00											;
									
				 case (opcode)						
					 6'b10_0011 :						
						 begin 	
						 
							 regwrite 	= 1								; 
							 alusrc 	= 1								; 
							 memtoreg 	= 1								; 
							 ALUOP 		= 2'b00							;
							 
						 end
						 
					 6'b10_1011 : 
						 begin 
						 
							 memwrite 	= 1								; 
							 alusrc 	= 1								;  
							 memtoreg 	= 1								; 
							 ALUOP 		= 2'b00							; 
							 
						 end	
						 
					 6'b00_0000 : 						
						 begin 	
						 
							 regwrite 	= 1								; 
							 regdst 	= 1								; 
							 ALUOP 		= 2'b10							; 
							 
						 end	
						 
					 6'b00_1000 : 						
						 begin 	
						 
							 regwrite 	= 1								; 
							 alusrc 	= 1								; 
							 ALUOP 		= 2'b00							; 
							 
						 end	
						 
					 6'b00_0100 : 						
						 begin 	
						 
							 ALUOP 		= 2'b01							; 
							 branch 	= 1								; 
							 
						 end	
						 
					 6'b00_0010 : 						
						 begin 	
						 
							jump 		= 1								; 
							
						 end
						 
					 default 	: 
						 begin 
						 
							 memtoreg 	= 0								; 
							 memwrite 	= 0								; 
							 branch 	= 0								; 
							 alusrc 	= 0								;
							 regdst 	= 0								;  
							 regwrite 	= 0								; 
							 ALUOP 		= 2'b00							;
							 
						end
				 
				 endcase               
		 
		 end


/***************************************************************************************************/
/*****************************	        ALU Decoder          ***************************************/


	always @(*)
	begin
	
		case (ALUOP)
		
			2'b00 : ALUControl = 3'b010									;
			2'b01 : ALUControl = 3'b100									;
			2'b10 : begin 
			
						case (funct)
						
							6'b10_0100	:	ALUControl = 3'b000			;
							6'b10_0101	:	ALUControl = 3'b001			;
							6'b10_0000 	: 	ALUControl = 3'b010			;
							6'b10_0010 	: 	ALUControl = 3'b100			;
							6'b10_1010 	: 	ALUControl = 3'b110			;
							6'b01_1100 	: 	ALUControl = 3'b101			;
							default 	: 	ALUControl = 3'b111			;
								
						endcase 	
						
					end    	
				
			default : ALUControl=3'b010									;
			
		endcase
	
	end

endmodule