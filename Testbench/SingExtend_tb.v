`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:06:53 01/22/2021
// Design Name:   SignExtend
// Module Name:   C:/Users/mvrb9/Desktop/Tec/Micros/proyecto/Proce/ProyectoMicrosFinal/SingExtend_tb.v
// Project Name:  ProyectoMicrosFinal
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SignExtend
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
/*
Objetivo de la prueba: El objetivo es demostrar el buen funcionamiento de este módulo mediante una prueba consistente
en observar el comportamiento del módulo ante una valor determinado y un caso de estudio, es decir, si tiene un caso para
cada tipo de decodificación. El resultado esperado se encuentra al costado del caso.
*/
module SignExtend_tb;

	// Inputs
	reg [31:0] inst;
	reg [2:0] IMM_SRC;

	// Outputs
	wire [31:0] imm;

	// Instantiate the Unit Under Test (UUT)
	SignExtend uut (
		.inst(inst), 
		.IMM_SRC(IMM_SRC), 
		.imm(imm)
	);

	initial begin
		// Initialize Inputs
		IMM_SRC = 0;
		inst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		IMM_SRC = 3'b000;     // Tipo I 
		inst = 32'h00500793;		//Resultado: 32'h00000005
		#10;
		IMM_SRC = 3'b001;		// Tipo U
		inst = 32'h0000b7b7;	//Resultado: 32'h0000b000
		#10;
		IMM_SRC = 3'b010;    // Tipo S
		inst = 32'hfef42423; //Resultado: 32'hffffffe8
		#10;
		IMM_SRC = 3'b011;		//Tipo J
		inst = 32'h00c0006f; //Resultado: 32'h0000000c
		#10;
		IMM_SRC = 3'b100;    //Tipo B
		inst = 32'h00f71863; //32'h00000002
		#10;
		IMM_SRC = 3'b101;		//No implementado
		inst = 32'h01234567; //32'h00000000
		#10;
	end
      
endmodule

