`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:15:04 01/22/2021
// Design Name:   GPIO
// Module Name:   C:/Users/mvrb9/Desktop/Tec/Micros/proyecto/Proce/ProyectoMicrosFinal/GPIO_tb.v
// Project Name:  ProyectoMicrosFinal
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: GPIO
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module GPIO_tb;
/*
Objetivos de la prueba: Se espera demostrar el buen funcionamiento del módulo comprobando que unicamente se muestre
el resultado cuando la entrada "a" sea abcd.
Resultados esperados: mientras "a" sea 1 out debería permanecer en 0 y cuando "a" sea abcd deberá cambiar a 8
*/
	// Inputs
	reg [31:0] a;
	reg [31:0] d;
	reg CLK;

	// Outputs
	wire [31:0] out;

	// Instantiate the Unit Under Test (UUT)
	GPIO uut (
		.a(a), 
		.d(d), 
		.CLK(CLK), 
		.out(out)
	);

	always #10 CLK = !CLK;
	initial begin
		// Initialize Inputs
		a = 0;
		d = 8;
		CLK = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		//Se setea la entrada a como un valor distinto a abcd y luego como abcd para verificar su funcionamiento
		#10;
		a = 1; //Out no deberia cambiar
		#10;
		a = 32'habcd; //Out deberia ser igual a d
		#10;
	end
      
endmodule

