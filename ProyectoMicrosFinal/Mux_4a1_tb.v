`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:10:30 01/22/2021
// Design Name:   Mux_4a1
// Module Name:   C:/Users/mvrb9/Desktop/Tec/Micros/proyecto/Proce/ProyectoMicrosFinal/Mux_4a1_tb.v
// Project Name:  ProyectoMicrosFinal
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Mux_4a1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
/*
Objetivo de la prueba: Se buscará comprobar el buen funcionamiento del selector y que la asignación sea la correcta 
mediante una prueba corta. El resultado se ecuentra al lado de la sálida.
*/ 
module Mux_4a1_tb;

	// Inputs
	reg [1:0] Ctrl;
	reg [31:0] Entrada1;
	reg [31:0] Entrada2;
	reg [31:0] Entrada3;

	// Outputs
	wire [31:0] Mux_Out;

	// Instantiate the Unit Under Test (UUT)
	Mux_4a1 uut (
		.Ctrl(Ctrl), 
		.Entrada1(Entrada1), 
		.Entrada2(Entrada2), 
		.Entrada3(Entrada3), 
		.Mux_Out(Mux_Out)
	);

	initial begin
		// Initialize Inputs
		Ctrl = 0;
		//Se setean las entradas a valores arbitrarios
		Entrada1 = 1;
		Entrada2 = 2;
		Entrada3 = 3;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		//Se cambia el control de 0 a 2 para verificar que la salida cambie en función del control
		//No se setea en 3 ya que la cuarta patilla no se encuentra implementada
		#10;
		Ctrl = 0; //Entrada 1
		#10;
		Ctrl = 1; //Entrada 2
		#10;
		Ctrl = 2; //Entrada 3
		

	end
      
endmodule

