module Register (

	input 	wire 	[4:0] 	A1							,
	input 	wire 	[4:0] 	A2							,
	input 	wire 	[4:0] 	A3							,
	input 	wire 	[31:0] 	WD3							,
	input 	wire  			WE3							,
	input 	wire  			CLK							,
	input 	wire  			rst							,

	output 	reg 	[31:0] 	RD1							,
	output 	reg 	[31:0] 	RD2

);

	reg     [31:0]    		Reg     [99:0]    			;

	integer 				i 							;

/***************************************************************************************************/
/***************************************************************************************************/	

	always@(posedge CLK or negedge rst)
		begin
		
			if (!rst)
				begin
				
				
					for (i = 0 ; i < 100 ; i = i + 1 )
					
						Reg [i] <= 32'b0				;
				
				end
				
			else if (WE3)
				begin
				
					Reg[A3] <= WD3 						;
				
				end
			
		end
	
/***************************************************************************************************/
/***************************************************************************************************/
	
	always@(*)
		begin
		
			RD1 = Reg[A1]								;
			RD2 = Reg[A2]								;
		
		end

endmodule		