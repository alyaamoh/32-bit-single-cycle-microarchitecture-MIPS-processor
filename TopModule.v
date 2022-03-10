module TopModule(

	input  wire 		CLK							,
	input  wire 		rst							,

	output wire [15:0]	test_value

);

	wire 				jump						;
    wire 				memtoreg					;
    wire 				memwrite					;
    wire 				branch						;
    wire 				alusrc						;
    wire 				regdst						;
    wire 				regwrite					;
    wire 	[2:0] 		ALUControl          		;

	wire 	[31:0] 		PC							;
	wire 	[31:0] 		ALuOut						;
	wire 	[31:0] 		WriteData					;	
	
	wire 	[31:0] 		RD							;
	wire 	[31:0] 		Instr						;


/***************************************************************************************************/
/***************************************************************************************************/

	controlunit control
	(
		.funct(Instr[5:0])							,
		.opcode(Instr[31:26])						,

		.jump(jump)									,
		.memtoreg(memtoreg)							,
		.memwrite(memwrite)							,
		.branch(branch)								,
		.alusrc(alusrc)								,
		.regdst(regdst)								,
		.regwrite(regwrite)							,
		.ALUControl(ALUControl) 		
	);	

/***************************************************************************************************/
/***************************************************************************************************/

	DataPath datapath 
	(

		.CLK(CLK)									,
		.rst(rst)									,
		.jump(jump)									,
		.memtoreg(memtoreg)							,
		.branch(branch)								,
		.alusrc(alusrc)								,
		.regdst(regdst)								,
		.regwrite(regwrite)							,
		.ALUControl(ALUControl) 					,
		.RD(RD)										,
		.Instr(Instr)								,
						
						
		.PC(PC)										,
		.ALuOut(ALuOut)								,
		.WriteData(WriteData)					

	);

/***************************************************************************************************/
/***************************************************************************************************/

	Inst_Mem instmem
	(

		.PC(PC)										,
		
		.Instr(Instr)

	);

/***************************************************************************************************/
/***************************************************************************************************/

	Data_Mem datamem
	(
		.A(ALuOut)									,
		.WD(WriteData)								,
		.WE(memwrite)								,
		.CLK(CLK)									,
		.rst(rst)									,
	
		.RD(RD)										,
		.test_value(test_value)
	);



endmodule