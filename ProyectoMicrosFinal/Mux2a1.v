`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:46:54 01/21/2021 
// Design Name: 
// Module Name:    Mux2a1 
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
/*MÓDULO Mux_2a1: El módulo Mux_2a1 es el encargado de multiplexar dos señales. Cuenta con 2 entradas de 32 bits y un
selector llamado OP1_SRC. Este módulo se utiliza 3 veces en todo el datapath, para multiplexar las entradas de la ALU
y multiplexar los posibles valor de PC (PC+4 y la sálida de la ALU para las instrucciones de tipo Branch).

ENTRADAS (3): Entrada1[31:0], Entrada2[31:0], OP1_SRC
SALIDAS (1):   Mux_Out[31:0]
*/
module Mux_2a1(
	input [31:0] Entrada1,
	input [31:0] Entrada2,
	output reg[31:0] Mux_Out,
	input OP1_SRC
);
//Se inicializa la sálida como 0
initial begin
Mux_Out = 0;
end

//Siempre que exista un cambio en las entradas se ejecutará lo siguiente
always @(*)

begin

//Cuando control es 0 se setea la sálida como Entrada 1
if (OP1_SRC == 0)
begin
	Mux_Out = Entrada1;
end

//Cuando control es 1 se setea la sálida como Entrada 2
else
begin
	Mux_Out = Entrada2;
end
end

endmodule
