`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:13:58 01/22/2021
// Design Name:   Memoria
// Module Name:   C:/Users/mvrb9/Desktop/Tec/Micros/proyecto/Proce/ProyectoMicrosFinal/Memoria_Datos_tb.v
// Project Name:  ProyectoMicrosFinal
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Memoria
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
/*
Objetivo de la prueba: Resumen de la prueba:
Se haran pruebas de escritura y lecture con y sin las operaciones de concatenacion byte. Primero se insertara un valor,
y se procede a leerlo. Se inserta 0 con byte_s activo y se prueba que aun queda parte del primer valor. Luego 
se inserta otro dato en otra direccion, y se lee con y sin byte_l para ver la concatenacion que ocurre.Por ultimo 
se hace un dump en un txt de los valores en la memoria.
*/
module Memoria_Datos_tb;

	// Inputs
	reg [31:0] ad;
	reg [31:0] di;
	reg we;
	reg re;
	reg clk;
	reg byte_l;
	reg byte_s;

	// Outputs
	wire [31:0] d_o;
	
	integer f;
	integer i;

	// Instantiate the Unit Under Test (UUT)
	Memoria uut (
		.ad(ad), 
		.di(di), 
		.we(we),
		.re(re),
		.clk(clk), 
		.byte_l(byte_l), 
		.byte_s(byte_s), 
		.d_o(d_o)
	);
	
	initial begin
		clk = 0;
	end
	
	always #1 clk = ~clk;
	
	initial begin
		// Initialize Inputs
		ad = 0;
		di = 0;
		we = 0;
		re = 0;
		byte_l = 0;
		byte_s = 0;
		
		f = $fopen("dump_memoria_datos.txt","w");

		// Wait 100 ns for global reset to finish
		
		#100;
		

		
		we = 1; //activa write enable
		ad = 8; //se coloca en la direccion 8
		
		#2; //espera un ciclo de reloj, para que reconozca we
		
		di = 2147483647; //valor a insertar
		
		#2;
		
		we = 0; //desactiva escritura, activa lectura
		re = 1;
		
		#2
		
		$display("\nLEYENDO %b en pos %d, real %d\n", d_o, ad, ad>>2); //lee el valor insertado
		//resultado esperado: leer 01111111111111111111111111111111
		
		re = 0; //desactiva lectura, activa escritura, activa byte_s, valor a insertar ahora es 0
		we = 1;
		byte_s = 1;
		di = 0;
		
		#2;
		
		we = 0;	//desactiva escritura, activa lectura, byte_s desactivado
		byte_s = 0;
		re = 1;
		
		#2;
		
		$display("LEYENDO %b en pos %d, real %d, CON byte_s\n", d_o, ad, ad>>2); //lee la salida para comprobar la concatenacion por byte_s
		//resultado esperado: leer 01111111111111111111111100000000
		
		we = 1; //activa escritura, desactiva lectura, pone la direccion ad en 20, y di cambia a otro valor (1010..1010) en binario
		re = 0;
		ad = 20;
		di = 2863311530;
		
		#2;

		we = 0;
		re = 1;
		
		#2;
		
		$display("LEYENDO %b en pos %d, real %d, SIN byte_l\n", d_o, ad, ad>>2); //lee el valor insertado, activa byte_l para volver a leer el proximo ciclo
		//resultado esperado: leer 10101010101010101010101010101010
		
		byte_l = 1; 

		#2;
		
		$display("LEYENDO %b en pos %d, real %d, CON byte_l\n", d_o, ad, ad>>2); //vuelve a leer, ahora deberia salir el valor concatenado por byte_l
		//resultado esperado: leer 00000000000000000000000010101010
		
		#100;
		
		//dump
		re = 1; //modo lectura, se coloca en el address 0 de nuevo
		byte_l = 0;
		we = 0;
		ad = 0;
		#2;
		$fwrite(f,"direccion  valor (hex)\n","");
		$fwrite(f,"0x%h 0x%h\n", 0, d_o);
		#2;
		for (i = 1; i<256; i=i+1) begin			
			ad = i*4;		
			#4;
			$fwrite(f,"0x%h 0x%h\n", i*4, d_o);
		end
			
		$fclose(f);
		$finish;
		
	end
      
endmodule

