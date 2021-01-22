`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:48:47 01/21/2021 
// Design Name: 
// Module Name:    Mux_4a1 
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
/*MÓDULO Mux_4a1: El módulo Mux4a1 es el encargado de multiplexar los posibles valores de di. Cuenta con 3 entradas de 
32 bits y una patilla de control de 2 bits. Finalmente, cuenta con una sálida de 32 bits a la que se le asigna 
un valor en función de control.

ENTRADAS (4): Ctrl[1:0], Entrada1[31:0], Entrada2[31:0], Entrada3[31:0]
SALIDAS (1):   Mux_Out[31:0]
*/

module Mux_4a1(
    	input [1:0] Ctrl,
		input [31:0] Entrada1,
		input [31:0] Entrada2,
		input [31:0] Entrada3,
		output reg[31:0] Mux_Out = 0
    );

//Siempre que haya un cambio en las entradas se ejecuta lo siguiente
always @ (*)

begin

//Si control es 0 se setea la sálida para que sea igual a entrada 1
if (Ctrl ==2'b00)
Mux_Out = Entrada1;

//Si control es 1 se setea la sálida para que sea igual a entrada 2
else if (Ctrl ==2'b01)
Mux_Out = Entrada2;

//Si control es 2 se setea la sálida para que sea igual a entrada 3
else if (Ctrl ==2'b10)
Mux_Out = Entrada3;

else
Mux_Out = 0;

end


endmodule
