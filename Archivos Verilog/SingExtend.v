`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:53:54 01/21/2021 
// Design Name: 
// Module Name:    SingExtend 
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
/*MÓDULO DE ACOMODO DEL INMEDIATO: Se encarga de preparar el valor inmediato según el tipo de decodificación que se 
está utilizando. Como se vio anteriormente, el uso de valores inmediatos varía según la decodificación. Por ello, el
extensor toma los bits [31:0] de la instrucción y los reacomoda en la palabra de 32 bits correcta para su uso en la 
ALU. Se rige por el selector IMM_SRC, cuyo valor determina el acomodo de bits que el extensor deberá efectuar,  
según la respectiva tabla de valores de IMM_SRC.

ENTRADAS (2): inst[31:0], IMM_SRC[2:0]
SALIDAS (1): imm[31:0]
*/

module SignExtend(inst, IMM_SRC, imm);

input [31:0] inst;		//Declaración de las entradas
input [2:0] IMM_SRC;

output reg [31:0] imm;	//Declaración de las salidas

initial begin		//Bloque de inicialización de las salidas
	imm = 0;
end

always @(*) begin		//Siempre que haya un cambio en la instrucción, el m?dulo acomodara el inmediato que trae
								//dicha instrucci?n en su HEX.
	case(IMM_SRC)
		3'b000:	imm = {{20{inst[31]}} , inst[31:20]};														//Tipo I
		3'b001:	imm = {inst[31:12] , {12{1'b0}}};															//Tipo U
		3'b010:	imm = {{20{inst[31]}} , inst[31:25] , inst[11:7]};										//Tipo S
		3'b011:	imm = {{12{inst[31]}} , inst[19:12] , inst[20] , inst[30:21] , 1'b0};			//Tipo J
		3'b100:	imm = {{20{inst[31]}} , inst[7] , inst[30:25] , inst[11:8] , 1'b0};				//Tipo B
		default:	imm = 0; 	//En caso que se tenga un valor no implementado, imm se pone en 0
	endcase
end

endmodule
