`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:17:41 01/22/2021
// Design Name:   Microprocesador
// Module Name:   C:/Users/mvrb9/Desktop/Tec/Micros/proyecto/Proce/ProyectoMicrosFinal/Rst_Test_tb.v
// Project Name:  ProyectoMicrosFinal
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Microprocesador
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
/*
Objetivo de la prueba: El objetivo de esta prueba es demostrar el buen funcionamiento de la patilla de reset en el
procesador general.
*/
module Rst_Test_tb;

	// Inputs
	reg Clk;
	reg Reset;

	// Instantiate the Unit Under Test (UUT)
	Microprocesador uut (
		.Clk(Clk), 
		.Reset(Reset)
	);
	initial begin
		// Initialize Inputs
		Clk = 0;
		Reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
		Reset = 1;
		#100;
		Reset = 0;
        
		// Add stimulus here

	end
      
endmodule

