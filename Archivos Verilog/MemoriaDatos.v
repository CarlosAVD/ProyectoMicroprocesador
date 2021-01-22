`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:38:00 01/21/2021 
// Design Name: 
// Module Name:    MemoriaDatos 
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
/*MÓDULO Memoria: El módulo de memoria es el encargado del manejo de la memoría de datos, desde el acceso, almacenamiento,
lectura y escritura en la matriz de memoría planteada. Se plantea una memoría de 256 espacios de 32 bits, la dirección
de cada espacio es tammbien de 32 bits. Cuenta con 7 entradas, una de ellas el clock, 2 de ellas son señales de control
para realizar lecturas, escrituras (we, re) y otras 2 para identificar el tamaño de la escritura o lectura (byte_l y byte_s).
Finalmente, se tienen 2 entradas de 32 bits cada cada, la dirección de memoría (ad) y la información a escribir (di).
Cuenta con una unica sálida llamda (Data_Out).

ENTRADAS (7): ad[31:0], di[31:0], we, re, clk, byte_1, byte_s
SALIDAS (1):   d_o[31:0]
*/
module Memoria(
		input wire [31:0] ad,          	// direccion de memoriaria
		input wire [31:0] di,    		// data in, lo que se escribe en la direccion
		input wire we,					// write enable, para escribir
		input wire re,					// read enable, para leer
		input wire clk,                 // clock
		input wire byte_l,      	// enable para load byte
		input wire byte_s,			// enable para la operacion store byte
		output reg [31:0] d_o			// data out
    );
	
	reg [31:0] memoria[255:0];  // 256 palabras de 32 bits

	integer i;	//variable para bucle for
	//registro que almacena la direccion real a accesar, se le realiza un divisón entre 4 para obtener la dirección real
	wire [7:0] real_addr = ad[9:2];	
	initial begin
		//inicializando salidas en 0
	  d_o = 0;	
	  
	  //llenando inicialmente la memoria con ceros
		i = 0;
		for (i = 0; i < 256; i = i + 1) begin 
			memoria[i] = 0; 
		end	  
	end

	// actualizacion de la memoria de acuerdo a los pines de entrada cada ciclo de reloj
	// ademas del pin de salida do
	always @(posedge clk) begin
	
	  if (we) begin
		case (byte_s)
			1'b1:
				begin //para la escritura, si el input byte_s esta alto concatena lo anterior en memoria y					
					memoria[real_addr] = {memoria[real_addr][31:8],di[7:0]};	//el 'byte' de di en el byte mas significativo de la direccion
				end
			1'b0:
				begin
					memoria[real_addr] = di;	// si byte_s no esta activo, coloca enteramente di en la direccion		
				end			
		endcase
	  end
	 end
	 //Para fines de orden la memoria escribe en el flanco positivo y lee en el flanco negativo
	 always @(negedge clk) begin
	  if (re) begin
		if (byte_l) begin //si byte_l esta activo, concatena 24 ceros junto con el byte mas significativo
			d_o = {{24{1'b0}}, memoria[real_addr][7:0]};
		end
		
		else begin
			d_o = memoria[real_addr];	//si byte_l no esta activo, coloca el contenido en la direccion en la salida
		end
	end
end

endmodule
