`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:34:27 01/21/2021 
// Design Name: 
// Module Name:    ALU 
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
/*MÓDULO ALU: El módulo ALU o unidad artmético lógica es el módulo encargado de la realización de todos los cálculos
y operaciones a nivel de bits que se deben realizar para las distintas instrucciones a ejecutar. Cuenta con 4 entradas, 
dos señales de control ALU_OP y JALR, las cuales se encargan de definir la operación a realizar y dos entradas de
32 de bits OP1 y OP2 que son los operandos de las operaciones. Cuenta con una única sálida que contiene el resultado
de las operaciones realizadas.

ENTRADAS (4): ALU_OP[2:0], OP1[31:0], OP2[31:0], JALR
SALIDAS (1):   ALU_Salida[31:0]
*/
module ALU(JALR, ALU_OP, OP1, OP2, ALU_Salida);
	 
input JALR;
input [2:0] ALU_OP;
input [31:0] OP1;
input [31:0] OP2;
output reg [31:0] ALU_Salida;

reg [31:0] Dummie;

initial begin
	ALU_Salida = 0;
end

always @ (*) begin

	case (ALU_OP)
		
		3'b000:	//ADD
		begin
			Dummie = OP1 + OP2;
			if (JALR) //Si la operación es un JALR se realiza el cambio del LSB a 0
				ALU_Salida = {Dummie[31:1], 1'b0};
			else
				ALU_Salida = Dummie; //Caso contrario suma con normalidad
		end
		
		3'b001: 	ALU_Salida = OP1 << OP2[4:0];  //SLLI

		3'b010:	ALU_Salida = OP1 - OP2; //SUB

		3'b011:	ALU_Salida = OP1 >> OP2[4:0];  //SRLI

		3'b100:	ALU_Salida = OP1 ^ OP2;  //XOR:

		3'b101:	ALU_Salida = $signed(OP1) >>> OP2[4:0]; //SRAI. OP1 tiene signo para que el shift aritmético funcione. 

		3'b111:	ALU_Salida = OP1 & OP2;   //AND
		
		default:	ALU_Salida = 0;
	
	endcase

end


endmodule
