module pc
(
    input  wire			clk					,
    input  wire			rst					,
    input  wire	[31:0] 	inpc				,
    
	output reg 	[31:0] 	outpc
	
);

/***************************************************************************************************/
/***************************************************************************************************/

	always @(posedge clk or negedge rst)
		begin
		
			if(!rst)
				begin
				
					outpc <= 32'b0			;
				
				end
			else
				begin
				
					outpc <= inpc			;
				
				end
		
		end

endmodule
