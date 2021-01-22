`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:10:10 01/22/2021
// Design Name:   Mux_2a1
// Module Name:   C:/Users/mvrb9/Desktop/Tec/Micros/proyecto/Proce/ProyectoMicrosFinal/Mux_2a1_tb.v
// Project Name:  ProyectoMicrosFinal
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Mux_2a1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
/*
Objetivo de la prueba: Se buscará comprobar el buen funcionamiento del selector y que la asignación sea la 
correcta mediante una prueba corta. El resultado se encuentra al lado de la sálida.
*/ 
module Mux_2a1_tb;

	// Inputs
	reg [31:0] Entrada1;
	reg [31:0] Entrada2;
	reg OP1_SRC;

	// Outputs
	wire [31:0] Mux_Out;

	// Instantiate the Unit Under Test (UUT)
	Mux_2a1 uut (
		.Entrada1(Entrada1), 
		.Entrada2(Entrada2), 
		.Mux_Out(Mux_Out), 
		.OP1_SRC(OP1_SRC)
	);

	initial begin
		// Initialize Inputs
		//Se setean los valores de entrada1 y entrada2 de forma arbitraria
		Entrada1 = 2;
		Entrada2 = 1;
		OP1_SRC = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		//Se cambia el valor del control para asegurarse que la salida cambie
		#10;
		OP1_SRC=0; //Entrada 1
		#10;
		OP1_SRC=1; //Entrada 2
		#10;
		//Fin de la prueba

	end
      
endmodule

