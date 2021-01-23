`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:55:13 01/21/2021 
// Design Name: 
// Module Name:    Comparador 
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
/*MÓDULO Comparador: El modulo comparador es el encargado de determianr si los valores contenidos en los registros
que coloco como sálida el banco de registros son iguales, esta comparación es necesaria para realizar la operación 
de tipo branch condicional. Tiene como entrada los dos registros  de 32 bits, en caso de ser iguales setea la salida
como 1 y si son distintos la setea como 0.

ENTRADAS (2): reg1[31:0], reg2[31:0]
SALIDAS (1):  Comparador_Salida[31:0]
*/

module Comparador(
		input [31:0] reg1,
		input [31:0] reg2,
		output reg Comparador_Salida = 0
    );

//Siempre que alguna entrada cambie ejecuta lo siguiente	 
always @(*)

begin

//Cuando son iguales envía un 1
if (reg1 == reg2)
Comparador_Salida = 1;

else
//Cuando son distintos envía un 0
Comparador_Salida = 0;

end

endmodule
