module Data_Mem 
(
	input 	wire [31:0] 	A							,
	input 	wire [31:0] 	WD							,
	input 	wire  			WE							,
	input 	wire 			CLK							,
	input 	wire 			rst							,

	output 	reg  [31:0] 	RD							,
	output 	reg  [15:0] 	test_value
	
);


	reg [31:0] RAM [99:0]								;
	
	integer i											;
	
/***************************************************************************************************/
/***************************************************************************************************/

	always@(posedge CLK or negedge rst)
		begin
		
			if (!rst)
				begin
					

					for (i = 0 ; i < 100 ; i = i + 1)
					
						RAM[i] <= 32'b0					;
				
				end
			else if (WE)
				begin
				
					RAM[A] <= WD						;
				
				end
		
		end

/***************************************************************************************************/
/***************************************************************************************************/

			
	always@(*)
		begin
		
			RD = RAM[A]									;
			test_value = RAM [32'b0] [15:0]				;

		
		end
	
endmodule	