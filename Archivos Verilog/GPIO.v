`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:46:04 01/22/2021 
// Design Name: 
// Module Name:    GPIO 
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
/*M�DULO GPIO: El m�dulo de GPIO se encarga de manejar la s�lida del microprocesador, posee dos entradas y un clock, 
"a" se encarga de revisar el momento en que se llega al puntero que apunta a la s�lida definido en todos los c�digos, 
"d" se encarga de traer la informaci�n y escribirla en la s�lida (out) del microprocesador.

ENTRADAS (3): a[31:0], d[31:0], CLK
SALIDAS (1):   out[31:0]
*/
module GPIO(
    input [31:0] a,
    input [31:0] d,
	 input CLK,
    output reg [31:0] out
    );

//Inicializaci�n de la s�lida
initial begin
	out = 0;
end

//Revisa con cada clock si "a" esta en la posici�n correcta
always @(posedge CLK) begin
	if (a == 32'habcd) begin
		out <= d; //Si es asi entonces coloca la informaci�n que trae "d" en el registro de s�lida
	end
end	

endmodule 