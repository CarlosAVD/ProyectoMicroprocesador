`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:18:05 01/22/2021
// Design Name:   Microprocesador
// Module Name:   C:/Users/mvrb9/Desktop/Tec/Micros/proyecto/Proce/ProyectoMicrosFinal/Microprocesador_tb.v
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
Objetivo de la prueba: Prueba general de la microarquitectura, la prueba consiste en dejar correr el código con un
clock establecido y observar como se comportan las distintas partes del circuito.
El resultado de esta prueba varía en función del código que se haya cargado en la memoria.
*/
module Microprocesador_tb;

	// Inputs
	reg Clk;
	reg Reset;
	
	//Outputs
	wire [31:0] gpio;
/*	
	//Parametros
	reg [31:0] deco[0:64];
	reg [31:0] datos[0:255];
	integer f;
	integer i;
	integer g;
	integer k;
*/
	// Instantiate the Unit Under Test (UUT)
	Microprocesador uut (
		.Clk(Clk), 
		.Reset(Reset),
		.gpio(gpio)
	);
	
	always #5 Clk = !Clk;
	initial begin
		// Initialize Inputs
		Clk = 1;
		Reset = 0;

		// Wait 100 ns for global reset to finish
      #100;
		
		// Add stimulus here
		

	end
	/*
      always @(posedge Clk)
		
		begin
		
			//Dump de memoria de programa
			if (uut.instruccion == 0)
			//force uut.RF.reset = 1;
			begin
				for (i = 0; i < 64; i = i+1)
					begin
					force uut.MemoriaPrograma.real_ad =  i;
					#2;
					deco[i] = uut.MemoriaPrograma.inst;
					#2;
				end
				f = $fopen("dump_memoria_programa.txt","w"); //se abre el archivo a escribir en modo lectura
				$fwrite(f,"direccion  valor (hex)\n","");		
				#5;
				for (i = 0; i<64; i=i+1) begin			
					$fwrite(f,"0x%d 0x%h\n", i, deco[i]);
					#5;
				end

				$fclose(f);
				
				//Dump de memoría de datos
				for (k = 0; k < 256; k = k+1)
					begin
					force uut.Memoria.real_addr =  k;
					//force uut.Memoria.re = 1;
					#2;
					datos[k] = uut.Memoria.d_o;
					#2;
				end
				g = $fopen("dump_memoria_datos.txt","w"); //se abre el archivo a escribir en modo lectura
				$fwrite(g,"direccion  valor (hex)\n","");		
				#1;
				for (k = 0; k<256; k=k+1) begin			
					$fwrite(g,"0x%d 0x%h\n", k, datos[k]);
					#1;
				end

				$fclose(g);
				$finish;	
			end //End if
	
			
		end //End always
		*/
endmodule

