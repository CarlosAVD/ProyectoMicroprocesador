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
/*MÓDULO GPIO: El módulo de GPIO se encarga de manejar la sálida del microprocesador, posee dos entradas y un clock, 
"a" se encarga de revisar el momento en que se llega al puntero que apunta a la sálida definido en todos los códigos, 
"d" se encarga de traer la información y escribirla en la sálida (out) del microprocesador.

ENTRADAS (3): a[31:0], d[31:0], CLK
SALIDAS (1):   out[31:0]
*/
module GPIO(
    input [31:0] a,
    input [31:0] d,
	 input CLK,
    output reg [31:0] out
    );

//Inicialización de la sálida
initial begin
	out = 0;
end

//Revisa con cada clock si "a" esta en la posición correcta
always @(posedge CLK) begin
	if (a == 32'habcd) begin
		out <= d; //Si es asi entonces coloca la información que trae "d" en el registro de sálida
	end
end	

endmodule 