`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:01:19 01/22/2021
// Design Name:   Comparador
// Module Name:   C:/Users/mvrb9/Desktop/Tec/Micros/proyecto/Proce/ProyectoMicrosFinal/Comparador_TB.v
// Project Name:  ProyectoMicrosFinal
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Comparador
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module Comparador_tb;
/*
Objetivos de la prueba: Se busca demostrar el buen funcionamiento del módulo mediante una prueba con varios casos 
de exito y fracaso. 
Resultados esperados: Se espera que para la primera prueba la salida se mantenga en 1, mientras que para las segunda
la salida se mantenga en 0
*/
	// Inputs
	reg [31:0] reg1; 
	reg [31:0] reg2;

	// Outputs
	wire Comparador_Salida;

	// Instantiate the Unit Under Test (UUT)
	Comparador uut (
		.reg1(reg1), 
		.reg2(reg2), 
		.Comparador_Salida(Comparador_Salida)
	);

	initial begin 
		// Initialize Inputs
		reg1 = 0;
		reg2 = 0;
	end
	
	integer k=0;
	initial begin
		#5; 
		for (k=0; k<100; k=k+1) //prueba 100 casos en los que las entradas son iguales
			begin
				reg1 = k; reg2 = k;//ambas entradas son iguales a k 
				#5; 
			end
 
		for (k=0; k<100; k=k+1) //prueba 100 casos en los que las entradas son diferentes
			begin
				reg1 = k; reg2 = k+1; //reg2 es reg1 +1
				#5; 
			end
			
	end
      
endmodule
