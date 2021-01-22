`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:03:31 01/22/2021
// Design Name:   RegistroPC
// Module Name:   C:/Users/mvrb9/Desktop/Tec/Micros/proyecto/Proce/ProyectoMicrosFinal/RegistroPC_tb.v
// Project Name:  ProyectoMicrosFinal
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RegistroPC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
/*
Objetivo de la prueba: Se busca comprobar el buen funcionamiento del módulo mediante una prueba consistente en dejar
correr el registro PC para luego resetarlo y dejarlo correr nuevamente, de esta forma se demostraria que el registro
es capaz de actualizar su valor.
*/
module RegistroPC_tb;

	// Inputs
	reg Clk;
	reg Reset;
	reg [31:0] PC_In;

	// Outputs
	wire [31:0] PC_Out;
	wire [31:0] PC_Out_Sig;

	// Instantiate the Unit Under Test (UUT)
	RegistroPC uut (
		.Clk(Clk), 
		.Reset(Reset), 
		.PC_In(PC_In), 
		.PC_Out(PC_Out), 
		.PC_Out_Sig(PC_Out_Sig)
	);

	initial begin
		// Initialize Inputs 
		Clk = 0;
		Reset = 0;
		PC_In = 0;
		#10;
	end
	
	always #5 Clk = !Clk; //Cada 5 ns alterna el valor del reloj (periodo de 10 ns)
	integer k=0;
	
	initial begin
		Reset = 1; //Se activa reset
		for (k=0; k<20; k=k+1) //Prueba 20 casos para verificar que las salidas no cambien mientras el reset está activo
		begin
			PC_In = k*10; 
			#10; 
		end
		#10; 
		Reset=0; //Se desactiva el reset
		for (k=0; k<50; k=k+1) //Prueba 50 casos para verificar que el desplazamiento PC+4 sea consistente en todos
		begin
			PC_In = k*10; 
			#10; 
		end
		Reset = 1; //Verifica que las salidas se reseteen correctamente 
		#100;
	end
	    
endmodule

