`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:14:22 01/22/2021
// Design Name:   MemoriaPrograma
// Module Name:   C:/Users/mvrb9/Desktop/Tec/Micros/proyecto/Proce/ProyectoMicrosFinal/Memoria_Programa_tb.v
// Project Name:  ProyectoMicrosFinal
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MemoriaPrograma
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

/*
Objetivo de la prueba: Se cargará un archivo y luego se realizará un dump de memoría para verificar la buena carga 
del archivo
*/
module Memoria_Programa_tb;

	// Inputs
	reg clk;
	reg [31:0] pc;

	// Outputs
	wire [31:0] inst; //salida de la instruccion
	integer f; //variable para abrir el archivo en el cual se realizara el dump
	integer i; //variable para bucle for

	// Instantiate the Unit Under Test (UUT)
	MemoriaPrograma uut (  
		.pc(pc), 
		.inst(inst)
	);
	

	initial begin
		// Initialize Inputs
		pc = 0;
		i = 0;
		f = $fopen("dump_memoria_programa.txt","w"); //se abre el archivo a escribir en modo lectura
		
		#200;
		
		//se imprime la instruccion en el indice cero
		$display("\nInstruccion cuando pc = %d : %h\n", pc, inst);
		//resultado esperado: inst = fd010113
		
		pc = 4; //se cambia la direccion del pc y se esperan dos ciclos de reloj para la lectura
		
		#4;
		
		//se imprime la direccion en el indice cuatro (segundo registro)
		$display("\nInstruccion cuando pc = %d : %h\n", pc, inst);
		//resultado esperado: inst = 02812623
		
		pc = 40;
		
		#4;
		//se imprime la direccion en el indice 40 (decima fila del registro)
		$display("\nInstruccion cuando = %d : %h\n", pc, inst);
		//resultado esperado: inst = 00300793
		
		pc = 100;
		
		#4;
		//imprime de nuevo, se espera que en la direccion 100 no haya nada, o sea cero
		$display("\nInstruccion cuando = %d : %h\n", pc, inst);
		
		pc = 0; //se reinicia el pc para hacer el dump en txt
		
		#4;
		
		//bucle para imprimir las instrucciones en un dump
		//recorre cada direccion, las asigna al pc, espera a que la salida actualice,
		//e imprime en el txt
		$fwrite(f,"direccion  valor (hex)\n","");		
		for (i = 0; i<64; i=i+1) begin			
			pc = i*4;
			#4;
			$fwrite(f,"0x%d 0x%h\n", pc, inst);
		end
			
		$fclose(f);
		$finish;		
	end
      
endmodule

