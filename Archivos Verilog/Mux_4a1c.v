`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:54:37 01/21/2021 
// Design Name: 
// Module Name:    Mux_4a1c 
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
/*MÓDULO Mux_4a1c: El módulo Mux_4a1c es el encargado de multiplexar la entrada a1 del banco de registros,
cuenta con 3 entradas de 5 bits cada una y una entrada de control de dos bits. Finalmente, cuenta con una
sálida de 5 bits se conecta a la patilla a1 del banco de registros.

ENTRADAS (4): Ctrl[1:0], Entrada1[4:0], Entrada2[4:0], Entrada3[4:0]
SALIDAS (1):   Mux_Out[4:0]
*/

module Mux_4a1c(
    	input [1:0] Ctrl,
		input [4:0] Entrada1,
		input [4:0] Entrada2,
		input [4:0] Entrada3,
		output reg[4:0] Mux_Out = 0
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
