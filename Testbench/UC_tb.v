`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:05:45 01/22/2021
// Design Name:   UnidadControl
// Module Name:   C:/Users/mvrb9/Desktop/Tec/Micros/proyecto/Proce/ProyectoMicrosFinal/UC_tb.v
// Project Name:  ProyectoMicrosFinal
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: UnidadControl
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
/*
Objetivo de la prueba: Esta prueba consiste en comprobar la capacidad de la UC para generar las señales de control
en función de la instrucción que se tiene. Debido a la gran cantidad de instrucciones y casos a considerar se decidio
seleccionar de forma aleatoria 3 intrucciones y utilizarlas como referente.
*/
module UC_tb;

	// Inputs
	reg funct7;
	reg [2:0] funct3;
	reg [6:0] opcode;
	reg comp;
	reg RST;

	// Outputs
	wire WE_Data;
	wire RE_Data;
	wire BYTE_STR;
	wire BYTE_LDR;
	wire [2:0] IMM_SRC;
	wire WE_Regs;
	wire [2:0] ALU_OP;
	wire JALR;
	wire PC_SRC;
	wire [1:0] RS1_SRC;
	wire OP1_SRC;
	wire OP2_SRC;
	wire [1:0] WRITE_SRC;

	// Instantiate the Unit Under Test (UUT)
	UnidadControl uut (
		.funct7(funct7), 
		.funct3(funct3), 
		.opcode(opcode), 
		.comp(comp),
		.RST(RST), 
		.WE_Data(WE_Data), 
		.RE_Data(RE_Data), 
		.BYTE_STR(BYTE_STR), 
		.BYTE_LDR(BYTE_LDR), 
		.IMM_SRC(IMM_SRC), 
		.WE_Regs(WE_Regs), 
		.ALU_OP(ALU_OP), 
		.JALR(JALR), 
		.PC_SRC(PC_SRC), 
		.RS1_SRC(RS1_SRC), 
		.OP1_SRC(OP1_SRC), 
		.OP2_SRC(OP2_SRC), 
		.WRITE_SRC(WRITE_SRC)
	);

	
	initial begin
		// Initialize Inputs
		funct7 = 0;
		funct3 = 0;
		opcode = 0;
		comp = 0;
		RST = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		//Resultados:| 0 | 0 | x | x | xxx | 1 | 000 | 0 | 0 | 0 | 1 | 0 | 01 | 
		funct7 = 0;
		funct3 = 000;
		opcode = 7'b0110011; //ADD
		comp = 0;
		#4;
		//Resultados:| 0 | 0 | x | x | xxx | 1 | 010 | 0 | 0 | 0 | 1 | 0 | 01 |
		funct7 = 1;
		funct3 = 000;
		opcode = 7'b0110011; //SUB
		comp = 0;
		#4;	
		//Resultados:| 0 | 0 | x | x | xxx | 1 | 100 | 0 | 0 | 0 | 0 | 0 | 01 |
		funct7 = 0;
		funct3 = 100;
		opcode = 7'b0010011;//XORI
		comp = 0;
		#4;
		
	end
      
endmodule

