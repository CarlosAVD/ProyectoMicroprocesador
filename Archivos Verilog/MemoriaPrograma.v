`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:40:58 01/21/2021 
// Design Name: 
// Module Name:    MemoriaPrograma 
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
/*M�DULO MemoriaPrograma: La memor�a de programa es el m�dulo encargado de almacenar los valores decodificados del c�digo
que se esta corriendo. Cuenta con 2 entradas, un reset y la entrada pc que es la encargada de determinar la direcci�n
de memor�a a la que se esta accesando. Cuenta con una �nica s�lida llamda inst que consiste en la decodificaci�n en binario
de la instrucci�n a ejectuar.

ENTRADAS (2): pc[31:0], rst
SALIDAS (1):   inst[31:0]
*/
module MemoriaPrograma(
input wire rst,
input wire [31:0] pc,
output reg [31:0] inst
    );

reg [31:0] mem_inst[0:63];
reg [29:0] real_ad;

integer i;
integer reseteando;

initial begin
	//inicializar valores
	inst = 0;
	for(i = 0; i<64; i=i+1)
	begin
		mem_inst[i] = 0;
	end
end

initial begin
	//cargar instrucciones hexadecimales de un txt (para cambiar de archivo se cambia esta l�nea)
	$readmemh("basicops.txt", mem_inst);
end

always @(*) begin
	real_ad <= pc>>2; //se hace un shift como division entre 4
	inst <= mem_inst[real_ad]; //se manda la instruccion indicada por el pc

	if(rst) begin
		i = 0;
		real_ad <= 0;
	end
end


endmodule

