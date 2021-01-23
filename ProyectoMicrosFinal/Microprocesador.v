`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:58:17 01/21/2021 
// Design Name: 
// Module Name:    Microprocesador 
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
/*MÓDULO Microprocesador: El módulo de Microprocesador se encarga de realizar las conexiones entre todos los módulos
que componen la arquitectura planteada. Con anterioridad se le asigno un nombre a cada nodo de manera que sea más ordenado
y sencilla la interconexión.  

ENTRADAS (2): Clk, Reset
SALIDAS (1):   gpio[31:0]
*/
module Microprocesador( 
	input Clk,
	input Reset,
	output [31:0] gpio
    );
//Definición de parametros
//---------------------------
integer f;
integer i;
integer pc;
integer g;
integer ad;
parameter zero = 0;
reg [31:0] instruccion;
wire [2:0] IMM_SRC;
wire [2:0] ALU_OP;
wire [1:0] RS1_SRC;
wire [1:0] WRITE_SRC;
wire [4:0] a1;
wire [31:0] Data_In; 
wire [31:0] D_Out1;
wire [31:0] D_Out2;
wire [31:0] PC_In;
wire [31:0] PC_Out;
wire [31:0] PC_Sig;
wire [31:0] Load_Data;
wire [31:0] ALU_Out;
wire [31:0] Inst;
wire [31:0] OP1;
wire [31:0] OP2;
wire [31:0] SE;
//-----------------------------------

//Se debe copiar en un registro el contenido de Inst, es decir, la salida de la memoria de programa
always @(*) begin
instruccion = Inst;
end

//-----------------------------------
//Inicio de la implementación de módulos
//-----------------------------------	 

//Unidad de control
//-----------------------------------
UnidadControl UC (
    .funct7(instruccion[30]), 
    .funct3(instruccion[14:12]), 
    .opcode(instruccion[6:0]), 
    .comp(Comp_Out),  
    .RST(Reset), 
    .WE_Data(WE_Data), 
    .RE_Data(RE_Data), 
    .BYTE_STR(BYTE_STR), 
    .BYTE_LDR(BYTE_LDR), 
    .IMM_SRC(IMM_SRC), 
    .WE_Regs(WE_Regs), 
    .ALU_OP(ALU_OP), 
    .JALR(JALR), 
    .PC_SRC(PC_SRC), 
    .RS1_SRC(RS1_SRC), 
    .OP1_SRC(OP1_SRC), 
    .OP2_SRC(OP2_SRC), 
    .WRITE_SRC(WRITE_SRC)
    );

//-------------------------------------

//Gpio
//-------------------------------------
GPIO Gpio (
	 .a(ALU_Out),
	 .d(D_Out2),
	 .CLK(Clk),
	 .out(gpio)
	 );
//-------------------------------------	 

//Banco de registros
//-------------------------------------
RegisterFile RF (
    .a1(a1), 
    .a2(instruccion[24:20]), 
    .ad(instruccion[11:7]), 
    .di(Data_In), 
    .we(WE_Regs), 
    .CLK(Clk), 
    .reset(Reset), 
    .do1(D_Out1), 
    .do2(D_Out2)
    );
//-------------------------------------


//Registro PC
//-------------------------------------
RegistroPC RPC (
    .Clk(Clk), 
    .Reset(Reset), 
    .PC_In(PC_In), 
    .PC_Out(PC_Out), 
    .PC_Out_Sig(PC_Sig)
    );
//-------------------------------------


//Memoria de datos
//-------------------------------------
Memoria Memoria (
    .ad(ALU_Out), 
    .di(D_Out2), 
    .we(WE_Data), 
    .re(RE_Data), 
    .clk(Clk), 
    .byte_l(BYTE_LDR), 
    .byte_s(BYTE_STR), 
    .d_o(Load_Data)
    );
//-------------------------------------

//Memoria de programa
//-------------------------------------	 
MemoriaPrograma MemoriaPrograma (
	 .rst(Reset),
    .pc(PC_Out), 
    .inst(Inst)
    );
//-------------------------------------

//Unidad aritmético lógica
//-------------------------------------
ALU ALU (
    .JALR(JALR), 
    .ALU_OP(ALU_OP), 
    .OP1(OP1), 
    .OP2(OP2), 
    .ALU_Salida(ALU_Out)
    );
//-------------------------------------

//SingExtend
//-------------------------------------
SignExtend SingExtend (
    .inst(instruccion), 
    .IMM_SRC(IMM_SRC), 
    .imm(SE)
    );
//-------------------------------------

//Comparador
//-------------------------------------
Comparador Comparador (
    .reg1(D_Out1), 
    .reg2(D_Out2), 
    .Comparador_Salida(Comp_Out)
    );
//-------------------------------------

//Mux_PC
//-------------------------------------
Mux_2a1 Mux_PC (
    .Entrada1(PC_Sig), 
    .Entrada2(ALU_Out), 
    .Mux_Out(PC_In), 
    .OP1_SRC(PC_SRC)
    );
//-------------------------------------

//Mux_OP1
//-------------------------------------
Mux_2a1 Mux_OP1 (
    .Entrada1(D_Out1), 
    .Entrada2(PC_Out), 
    .Mux_Out(OP1), 
    .OP1_SRC(OP1_SRC)
    );
//-------------------------------------

//Mux_OP2
//-------------------------------------
Mux_2a1 Mux_OP2 (
    .Entrada1(SE), 
    .Entrada2(D_Out2), 
    .Mux_Out(OP2), 
    .OP1_SRC(OP2_SRC)
    );
//-------------------------------------	

//Mux_a1
//-------------------------------------
Mux_4a1c Mux_a1 (
    .Ctrl(RS1_SRC), 
    .Entrada1(instruccion[19:15]), 
    .Entrada2(instruccion[11:7]), 
    .Entrada3(zero), 
    .Mux_Out(a1)
    );
//-------------------------------------

//Mux_di
//-------------------------------------
Mux_4a1 Mux_di (
    .Ctrl(WRITE_SRC), 
    .Entrada1(Load_Data), 
    .Entrada2(ALU_Out), 
    .Entrada3(PC_Sig), 
    .Mux_Out(Data_In)
    );
//-------------------------------------





endmodule
