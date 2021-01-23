`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:07:45 01/22/2021
// Design Name:   ALU
// Module Name:   C:/Users/mvrb9/Desktop/Tec/Micros/proyecto/Proce/ProyectoMicrosFinal/ALU_tb.v
// Project Name:  ProyectoMicrosFinal
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_tb;
/*
Objetivo de la prueba: El objetivo de esta prueba es determinar el buen funcionamiento de la ALU
probando con entradas abitrarias y un caso de cada operación a realizar.
Las respuestas esperadas se ecuentran al lado de la operación

*/
	// Inputs
	reg JALR;
	reg [2:0] ALU_OP;
	reg [31:0] OP1;
	reg [31:0] OP2;

	// Outputs
	wire [31:0] ALU_Salida;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.JALR(JALR), 
		.ALU_OP(ALU_OP), 
		.OP1(OP1), 
		.OP2(OP2), 
		.ALU_Salida(ALU_Salida)
	);

	initial begin
		// Initialize Inputs
		JALR = 0;
		ALU_OP = 0;
		OP1 = 0;
		OP2 = 0;

		// Wait 100 ns for global reset to finish
		#100;
      
		// Add stimulus here
		//Se setean las entradas en dos valores conocidos
		OP1 = 32'hf0206050;
		OP2 = 5;
		//Se pruba para cada tipo de operación tenendo un retraso de 10 segundos entre operación
		ALU_OP = 3'b001; //SLLI
		#10;
		ALU_OP = 3'b000; //SUMA
		#10;
		ALU_OP = 3'b000; //SUMA truncada
		JALR = 1;
		#10;
		ALU_OP = 3'b010; //RESTA
		JALR = 0;		
		#10;
		ALU_OP = 3'b011; //SRLI
		#10; 
		ALU_OP = 3'b100; //XOR
		#10;
		ALU_OP = 3'b101; //SRAI
		#10;
		ALU_OP = 3'b110; //No implementado
		#10;
		ALU_OP = 3'b111; //AND
		#10;
		
	end
      
endmodule
