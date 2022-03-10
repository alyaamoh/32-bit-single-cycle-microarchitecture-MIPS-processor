module mux 
#(parameter width=16)
(
    input  wire      [width-1:0]     in1	,
    input  wire      [width-1:0]     in2	,
    input  wire                      sel	,
    
	output reg   	[width-1:0]      out  
	
);

/***************************************************************************************************/
/***************************************************************************************************/

	always @(*)
		begin
			
			if (sel)
				begin
				
					out=in2					;
				
				end
			else
				begin
				
					out=in1					;
				
				end
		
		end 

endmodule