`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:22:12 01/21/2021
// Design Name:   RegisterFile
// Module Name:   C:/Users/mvrb9/Desktop/Tec/Micros/proyecto/Proce/ProyectoMicrosFinal/RF_Test.v
// Project Name:  ProyectoMicrosFinal
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RegisterFile
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RF_tb;
	// Inputs
	reg [4:0] a1;
	reg [4:0] a2;
	reg [4:0] ad;
	reg [31:0] di;
	reg we;
	reg CLK;
	reg reset;
	// Outputs
	wire [31:0] do1;
	wire [31:0] do2;
	// Instantiate the Unit Under Test (UUT)
	RegisterFile uut (
		.a1(a1), 
		.a2(a2), 
		.ad(ad), 
		.di(di), 
		.we(we), 
		.CLK(CLK), 
		.reset(reset), 
		.do1(do1), 
		.do2(do2)
	);
	initial begin
		//Inicializa entradas
		a1 = 0;
		a2 = 0;
		ad = 0;
		di = 0;
		we = 0;
		CLK = 0; 
		reset = 0;
		#100;
	end 
	//Test
	initial CLK = 0; //inicializa reloj en 0
	always #5 CLK = !CLK; //cada 5 ns alterna el valor del reloj (periodo de 10 ns)
	initial begin
		#1 reset = 1; we = 0; //resetea el banco de registros
		#5 reset = 0; //desactiva el reset
	end
	integer k = 0; //variable para utilizar como ?ndice
	initial
		begin
			#7 //espera a que se desactive el reset
			for (k=0; k<32; k=k+1) //empieza ciclo de escritura en todos los registros
				begin
					ad = k; di = 10*k; we = 1; //en cada registro, coloca como dato el n?mero de registro multiplicado por 10 
					#10 we = 0; //desactiva enable de escritura
				end
			#20 
			for (k=0; k<32; k=k+2) //empieza ciclo de lectura de cada registro
				begin
					a1 = k; a2 = k+1; //lee los datos de dos registros simult?neamente
					#10
					$display ("reg[%2d] = %d, reg[%2d]) = %d", a1, do1, a2, do2); //muestra en la consola el dato almacenado en cada uno de los registros 
				end
			#50 $finish; //termina la simulaci?n 
		end            
endmodule

