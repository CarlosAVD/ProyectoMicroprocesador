`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:36:33 01/21/2021 
// Design Name: 
// Module Name:    RegisterFile 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
/*MÓDULO RegisterFile: El módulo de banco de registros es el encargado del manejo y almacenamiento de los distintos
registros a utilizar. Para la microarquitectura RISC-V se tiene un total de 32 registros de 32 bits cada uno. La dirección
de cada registro esta dada por un valor del 0 al 32 y es manejado por variables de 5 bits. Cuenta con 7 entradas, dos de
ellas clock y reset, una señal de control Write_Enable que permite la escritura, luego se tienen 3 entradas de 5 bits que 
funcionan como dirección a los registros y finalmente, una entrada de 32 bits llamda Data_In(di) que contiene la información
que debe ser escrita en el registro destino. 

ENTRADAS (7): a1[4:0], a2[4:0], ad[4:0], di[31:0], we, CLK, reset
SALIDAS (2):   do1[31:0], do2[31:0]
*/
module RegisterFile(
    input [4:0] a1, //dirección de primer registro para leer (5 bits)
    input [4:0] a2, //dirección de segundo registro para leer (5 bits)
    input [4:0] ad, //dirección de registro en el que escribir
    input [31:0] di, //dato para escribir en ad
    input we, //enable para escribir 
	 input CLK, //señal de reloj del sistema
	 input reset, //señal para resetear sistema
    output [31:0] do1, //dato de salida de do1
    output [31:0] do2  //dato de salida de do2
    );	 
	 integer k;	//variable que se utilizará como índice 
	 reg [31:0] regfile[0:31];	//arreglo de 32 registros de 32 bits cada uno
	 initial begin
//		 do1=0; //inicializa salida do1
//		 do2=0; //inicializa salida do2
		 for (k=0; k<32; k=k+1) begin //inicia loop en el que...
					regfile[k] = 0;     //inicializa los datos almacenados en los registros
		 end
	 end
	 always@(posedge CLK)                 //siempre en flanco positivo de reloj...
		begin
		
			if (reset) begin                //si el reset está en alto...
				for (k=0; k<32; k=k+1) begin //inicia loop en el que...
					regfile[k] = 0;          //se resetean los datos almacenados en cada registro
				end
				
			end
			else begin 		
		
				if (we)  		//si el enable permite escritura...
				begin             
					if (ad != 0)
						regfile[ad] = di; //escribir el dato di en número de registro que especifica ad	
				end
			end
		end
	
	assign 	do1 = regfile[a1];   //asignar combinacionalmente a do1 el dato almacenado en a1
	assign	do2 = regfile[a2];	 //asignar combinacionalmente a do2 el dato almacenado en a2 
	
				
endmodule
