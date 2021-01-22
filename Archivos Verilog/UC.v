`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:32:43 01/21/2021 
// Design Name: 
// Module Name:    UnidadControl 
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
/*M�DULO DE LA UNIDAD DE CONTROL: La unidad de control es aquel m�dulo que se encarga de la generaci�n de las se�ales 
que controlan las partes del datapath, para el correcto manejo de las instrucciones en el procesador. Para esta micro-
arquitectura, la UC se encarga de la generaci�n de las 13 se�ales de control necesarias en el datapath a partir de 4 
entradas esenciales: los c�digos Funct7, Funct3 y Opcode de las instrucciones de RISCV (espec�ficamente los bits [30], 
[14:12] y [6:0] de cada instrucci�n) y la se�al COMP del comparador de igualdad. 

ENTRADAS (6): funct7, CLK, RST, comp, funct3[2:0] y opcode[6:0]
SALIDAS (13): WE_Data, RE_Data, BYTE_STR, BYTE_LDR, WE_Regs, PC_SRC, OP1_SRC, OP2_SRC, JALR, RS1_SRC[1:0], WRITE_SRC[1:0],
			IMM_SRC[2:0], ALU_OP[2:0]
*/

module UnidadControl(funct7, funct3, opcode, comp, RST, WE_Data, RE_Data, BYTE_STR, BYTE_LDR, IMM_SRC, 
			 WE_Regs, ALU_OP, JALR, PC_SRC, RS1_SRC, OP1_SRC, OP2_SRC, WRITE_SRC);

input 		RST, funct7, comp; //Declaraci�n de las entradas
input [2:0] funct3;
input [6:0] opcode;

output reg [2:0] IMM_SRC, ALU_OP;	//Declaraci�n de las salidas
output reg [1:0] RS1_SRC, WRITE_SRC;
output reg WE_Data, RE_Data, BYTE_STR, BYTE_LDR, WE_Regs, PC_SRC, OP1_SRC, OP2_SRC, JALR;

initial begin 					 	//Este bloque permite la inicializaci�n de las se�ales de control en la primera
	IMM_SRC = 3'b000;        	//ejecuci�n de la UC
	ALU_OP = 3'b000;
	RS1_SRC = 2'b00; 
	WRITE_SRC = 2'b00;
	WE_Data = 1'b0;
	RE_Data = 1'b0;
	BYTE_STR = 1'b0;
	BYTE_LDR = 1'b0;
	WE_Regs = 1'b0;
	PC_SRC = 1'b0; 
	OP1_SRC = 1'b0;
	OP2_SRC = 1'b0;
	JALR = 1'b0;
end

always @(funct7 or funct3 or comp or opcode) begin 	//Es bloque permite la actualizaci�n de las se�ales de control en dependencia de la
										//instrucci�n que se est� ejecutando en el momento.
										//Recuerde que el procesador es uniciclo, por lo que con cada ciclo de reloj se ejecuta
										//solo una instrucci�n.
										
	if (RST) begin					//Este bloque permite la reinicializaci�n de las se�ales de control en caso de que 
		IMM_SRC = 3'b000;       //se reciba un alto en la se�al de RESET
		ALU_OP = 3'b000;
		RS1_SRC = 2'b00; 
		WRITE_SRC = 2'b00;
		WE_Data = 1'b0;
		RE_Data = 1'b0;
		BYTE_STR = 1'b0;
		BYTE_LDR = 1'b0;
		WE_Regs = 1'b0;
		PC_SRC = 1'b0; 
		OP1_SRC = 1'b0;
		OP2_SRC = 1'b0;
		JALR = 1'b0;
	end
	
/*Las instrucciones de RISCV-32I necesarias se conglomeran en 8 distintos opcodes. Por ello, se plantea un
switch-case en donde se asignan las se�ales de control seg�n el opcode dado, tomando como base la tabla de verdad
en la que se basa esta unidad de control. En caso de que ingresase un opcode no soportado, se trabaja como si fuese 
un RST en alto*/

	case (opcode)
		7'b0110011: 	//Instrucciones ADD y SUB
			begin
				WE_Data = 1'b0; 		//IMM_SRC, BYTE_STR y BYTE_LDR no se usan en este caso, su valor es x. Por ello no se incluyen. 
				RE_Data = 1'b0;
				WE_Regs = 1'b1;
				JALR = 1'b0;
				PC_SRC = 1'b0; 
				OP1_SRC = 1'b0;
				OP2_SRC = 1'b1;
				RS1_SRC = 2'b00;
				WRITE_SRC = 2'b01;
				if (funct7 == 0)
					ALU_OP = 3'b000;
				else
					ALU_OP = 3'b010;
			end
		7'b0010011:		//Instrucciones ADDI, XORI, ANDI, SLLI, SRLI y SRAI (y pseudoinstrucciones LI y NOP)
			begin
				WE_Data = 1'b0; 		//BYTE_STR y BYTE_LDR no se usan en este caso, su valor es x. Por ello no se incluyen. 
				RE_Data = 1'b0;
				IMM_SRC = 3'b000;
				WE_Regs = 1'b1;
				JALR = 1'b0;
				PC_SRC = 1'b0; 
				OP1_SRC = 1'b0;
				OP2_SRC = 1'b0;
				RS1_SRC = 2'b00;
				WRITE_SRC = 2'b01;
				if ((funct3 == 3'b101)&&(funct7 == 0)) begin
					ALU_OP = 3'b011;
				end else begin
					ALU_OP = funct3;
				end
			end			
		7'b0000011:		//Instrucciones LW y LBU
			begin
				WE_Data = 1'b0;
				RE_Data = 1'b1;
				IMM_SRC = 3'b000;
				WE_Regs = 1'b1;
				ALU_OP = 3'b000;
				JALR = 1'b0;
				PC_SRC = 1'b0; 
				OP1_SRC = 1'b0;
				OP2_SRC = 1'b0;
				RS1_SRC = 2'b00;
				WRITE_SRC = 2'b00;
				BYTE_STR = 1'b0;
				BYTE_LDR = funct3[2];
			end
		7'b0100011: 	//Instrucciones SW y SB
			begin
				WE_Data = 1'b1;		//WRITE_SRC no se usa en este caso, su valor es x. Por ello no se incluye. 
				RE_Data = 1'b0;
				IMM_SRC = 3'b010;
				WE_Regs = 1'b0;
				ALU_OP = 3'b000;
				JALR = 1'b0;
				PC_SRC = 1'b0; 
				OP1_SRC = 1'b0;
				OP2_SRC = 1'b0;
				RS1_SRC = 2'b00;
				BYTE_STR = !funct3[1];
				BYTE_LDR = 1'b0;
			end	
		7'b0110111:		//Instrucci�n LUI
			begin
				WE_Data = 1'b0; 		//BYTE_STR y BYTE_LDR no se usan en este caso, su valor es x. Por ello no se incluyen. 
				RE_Data = 1'b0;
				IMM_SRC = 3'b001;
				WE_Regs = 1'b1;
				ALU_OP = 3'b000;
				JALR = 1'b0;
				PC_SRC = 1'b0; 
				OP1_SRC = 1'b0;
				OP2_SRC = 1'b0;
				RS1_SRC = 2'b10;
				WRITE_SRC = 2'b01;
			end
		7'b1101111:		//Instrucci�n JAL (y pseudoinstrucci?n J)
			begin
				WE_Data = 1'b0; 		//BYTE_STR y BYTE_LDR no se usan en este caso, su valor es x. Por ello no se incluyen. 
				RE_Data = 1'b0;
				IMM_SRC = 3'b011;
				WE_Regs = 1'b1;
				ALU_OP = 3'b000;
				JALR = 1'b0;
				PC_SRC = 1'b1; 
				OP1_SRC = 1'b1;
				OP2_SRC = 1'b0;
				RS1_SRC = 2'b01;
				WRITE_SRC = 2'b10;
			end
		7'b1100111:		//Instrucci�n JALR (y pseudoinstrucci�n RET)
			begin
				WE_Data = 1'b0; 		//BYTE_STR y BYTE_LDR no se usan en este caso, su valor es x. Por ello no se incluyen. 
				RE_Data = 1'b0;
				IMM_SRC = 3'b000;
				WE_Regs = 1'b1;
				ALU_OP = 3'b000;
				JALR = 1'b1;
				PC_SRC = 1'b1; 
				OP1_SRC = 1'b0;
				OP2_SRC = 1'b0;
				RS1_SRC = 2'b00;
				WRITE_SRC = 2'b10;
			end
		7'b1100011:		//Instrucci�n BNE
			begin
				WE_Data = 1'b0; 		//WRITE_SRC, BYTE_STR y BYTE_LDR no se usan en este caso, su valor es x. Por ello no se incluyen. 
				RE_Data = 1'b0;
				IMM_SRC = 3'b100;
				WE_Regs = 1'b0;
				ALU_OP = 3'b000;
				JALR = 1'b0;
				PC_SRC = !comp; 
				OP1_SRC = 1'b1;
				OP2_SRC = 1'b0;
				RS1_SRC = 2'b00;
			end
		default:		//Bloque para el tratamiento de opcodes no soportados por la arquitectura
			begin
				IMM_SRC = 3'b000;
				ALU_OP = 3'b000;
				RS1_SRC = 2'b00; 
				WRITE_SRC = 2'b00;
				WE_Data = 1'b0;
				RE_Data = 1'b0;
				BYTE_STR = 1'b0;
				BYTE_LDR = 1'b0;
				WE_Regs = 1'b0;
				PC_SRC = 1'b0; 
				OP1_SRC = 1'b0;
				OP2_SRC = 1'b0;
				JALR = 1'b0;
			end				
	endcase
end

endmodule 