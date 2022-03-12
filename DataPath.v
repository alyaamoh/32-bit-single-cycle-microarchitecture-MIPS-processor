/**************************************************************************************************/
/**************************************************************************************************/
/*****************************		Author: Alyaa Mohamed 	***************************************/
/*****************************		Module: Data Path   	***************************************/
/**************************************************************************************************/
/**************************************************************************************************/

module DataPath(

	input  wire 			CLK					,
	input  wire 			rst					,
	input  wire 			jump				,
	input  wire 			memtoreg			,
	input  wire 			branch				,
	input  wire 			alusrc				,
	input  wire 			regdst				,
	input  wire 			regwrite			,
	input  wire [2:0] 		ALUControl 			,
	input  wire [31:0] 		RD					,
	input  wire [31:0] 		Instr				,
		
		
	output wire [31:0] 		PC					,
	output wire [31:0] 		ALuOut				,
	output wire [31:0] 		WriteData					

);

/*****************************	     Internal signal         ***************************************/

	wire 		[4:0]		A3					;
	wire 		[31:0] 		RD1					;
	wire 		[31:0] 		RD2					;

	wire 		[31:0]		WD3					;
	
	wire 		[31:0] 		SignImm				;

	wire 		[31:0] 		mux_alu_out			;
	wire 					zero				;
	
	wire 		[31:0] 		shift_PC_out		;
	
	wire 		[31:0] 		PC_Adder_plus_4_out	;
	
	wire 		[31:0] 		PC_Adder_out		;
	wire					PCSrc				;

	wire		[31:0] 		shift_InstMem_out	;

	wire 		[31:0]		mux_InstMem_1_out	;
	wire 		[31:0]		mux_InstMem_2_out	;

/***************************************************************************************************/
/***************************************************************************************************/

	mux 
	#(.width(5))
	mux_reg 
	(
		//
		.in1(Instr[20:16])						,
		.in2(Instr[15:11])						,
		.sel(regdst)							,
		
		.out(A3)  
	);


	Register Reg (

		.A1(Instr[25:21])						,
		.A2(Instr[20:16])						,
		.A3(A3)									,
		.WD3(WD3)								,
		.WE3(regwrite)							,
		.CLK(CLK)								,
		.rst(rst)								,
		
		.RD1(RD1)								,
		.RD2(WriteData)

	);

/***************************************************************************************************/
/***************************************************************************************************/

	SignExtend sign_ext
	(

		.Inst(Instr[15:0])						,
		
		.imm(SignImm) 

	);

/***************************************************************************************************/
/***************************************************************************************************/

	mux 
	#(.width(32))
	mux_alu
	(
		.in1(WriteData)							,
		.in2(SignImm)							,
		.sel(alusrc)							,
		
		.out(mux_alu_out)								  
	);


	ALU alu
	(
		.SrcA(RD1)								,
		.SrcB(mux_alu_out)						,
		.ALUControl(ALUControl)					,
		
		.ALUResult(ALuOut)						,
		.Zero_flag(zero)
	);

/***************************************************************************************************/
/***************************************************************************************************/

	mux  
	#(.width(32))
	mux_DataMem
	(
		.in1(ALuOut)							,
		.in2(RD)								,
		.sel(memtoreg)							,
		
		.out(WD3)  
	);

/***************************************************************************************************/
/***************************************************************************************************/

	adder PC_Adder_plus_4 
	(
		.a(PC)									,
		.b(32'd4)								,
		
		.c(PC_Adder_plus_4_out)
	);


	adder PC_Adder 
	(
		.a(shift_PC_out)						,
		.b(PC_Adder_plus_4_out)					,
		
		.c(PC_Adder_out)
	);

	shift_left_twice 
	#(.width(32))
	shift_PC_Adder
	(
		.in(SignImm)							,
		
		.out(shift_PC_out)
	);

/***************************************************************************************************/
/***************************************************************************************************/

	shift_left_twice 
	#(.width(32))
	shift_InstMem
	(
		.in({{6'b000000},{Instr[25:0]}})		,
		
		.out(shift_InstMem_out)
	);


	assign PCSrc = zero & branch				;


	mux  
	#(.width(32))
	mux_InstMem_1
	(
		.in1(PC_Adder_plus_4_out)				,
		.in2(PC_Adder_out)						,
		.sel(PCSrc)								,
		
		.out(mux_InstMem_1_out)  
	);

	mux  
	#(.width(32))
	mux_InstMem_2
	(
		.in1(mux_InstMem_1_out)					,
		.in2( {{PC_Adder_plus_4_out[31:28]},{shift_InstMem_out[27:0]}} ),
		.sel(jump)								,
		
		.out(mux_InstMem_2_out)  
	);

/***************************************************************************************************/
/***************************************************************************************************/

	pc PC0
	(
		.clk(CLK)								,
		.rst(rst)								,
		.inpc(mux_InstMem_2_out)				,
		
		.outpc(PC)
	);



endmodule

