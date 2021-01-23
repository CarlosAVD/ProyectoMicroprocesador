`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:01:06 01/22/2021
// Design Name:   Microprocesador
// Module Name:   C:/Users/mvrb9/Desktop/Tec/Micros/proyecto/Proce/ProyectoMicrosFinal/Prueba1.v
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

module Prueba1;

	// Inputs
	reg Clk;
	reg Reset;
	
	//Outputs
	wire [31:0] gpio;

	// Instantiate the Unit Under Test (UUT)
	Microprocesador uut (
		.Clk(Clk), 
		.Reset(Reset),
		.gpio(gpio)
	);
	
	always #100 Clk = !Clk;
	initial begin
		// Initialize Inputs
		Clk = 1;
		Reset = 0;

		// Wait 100 ns for global reset to finish
      
		/*#1000;
		Reset = 1;
		#1000;
		Reset = 0;*/
		
		// Add stimulus here

	end
      
endmodule

