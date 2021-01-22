`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:44:32 01/21/2021 
// Design Name: 
// Module Name:    RegistroPC 
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
/*MÓDULO DE REGISTRO PC: Módulo encargado del manejo del registro PC, cuenta con 3 entradas, clock, reset y PC_In,
este ultimo corresponde al cable que entra y trae el valor actual de PC, es decir, la linea de código a ejectuar.
Cuenta además con 2 sálidas PC_Out el cual simplemente saca el valor de PC_In y PC_Out_Sig la cual contiene el valor de
PC_In+4.

ENTRADAS (3): Clk, Reset, PC_In[31:0]
SALIDAS (2): PC_Out[31:0], PC_Out_Sig[31:0] 
*/

module RegistroPC(
	input Clk,
	input Reset,
	input [31:0]PC_In,
	output reg [31:0] PC_Out,
	output reg [31:0] PC_Out_Sig
    );
	 
initial 
//Se establecen los valores iniciales de los registros de salida
begin

PC_Out = 0;
PC_Out_Sig = 0;

end

//Con cada flanco positivo de reloj se ejecuta la siguiente 
always @(posedge Clk)

begin
//Cuando reset se active se regresará a la primera instrucción, es decir, PC_Out = PC_Out_Sig =0
if (Reset == 1) begin

PC_Out = 0;
PC_Out_Sig = 0;

end
//Siempre que reset no este en uno se mostrará en salida PC_In y para PC_Out_Sig PC_In +4
//esto por que para algunas operaciones es necesario el valor de PC+4
else begin
PC_Out = PC_In;
PC_Out_Sig = PC_In +4;

end
end

endmodule
