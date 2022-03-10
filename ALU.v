module ALU
(
	input  wire    [31:0]        SrcA									,
	input  wire    [31:0]        SrcB									,
	input  wire    [2:0]         ALUControl								,

	output reg     [31:0]        ALUResult								,
	output reg                   Zero_flag
);

/***************************************************************************************************/
/***************************************************************************************************/

	always @(*)
	begin


		case (ALUControl)
			3'b000 : ALUResult = SrcA & SrcB							;
			3'b001 : ALUResult = SrcA | SrcB							;
			3'b010 : ALUResult = SrcA + SrcB							;
			3'b011 : ALUResult = 32'b0									;
			3'b100 : ALUResult = SrcA - SrcB							;
			3'b101 : ALUResult = SrcA * SrcB							;
			3'b110 : ALUResult = (SrcA < SrcB) ? 32'b1 : 32'b0 			;
			3'b111 : ALUResult = 32'b0									;
		endcase

	end

/***************************************************************************************************/
/***************************************************************************************************/

	always @(*)
		begin
		
			if ((ALUControl == 3'b011) || (ALUControl == 3'b111))
			
					Zero_flag = 1'b0									;
			
			else if (ALUResult == 32'b0)	
				
					Zero_flag = 1'b1									;
   	
			else 	
				
					Zero_flag = 1'b0									;
		  
		
		end   

endmodule