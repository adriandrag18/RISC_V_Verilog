`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2020 09:16:53 PM
// Design Name: 
// Module Name: EX
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module EX(input [31:0] IMM_EX,         
          input [31:0] REG_DATA1_EX,
          input [31:0] REG_DATA2_EX,
          input [31:0] PC_EX,
          input [2:0] FUNCT3_EX,
          input [6:0] FUNCT7_EX,
          input [4:0] RD_EX,
          input [4:0] RS1_EX,
          input [4:0] RS2_EX,
          input RegWrite_EX,
          input MemtoReg_EX,
          input MemRead_EX,
          input MemWrite_EX,
          input [1:0] ALUop_EX,
          input ALUSrc_EX,
          input Branch_EX,
          input [1:0] forwardA, forwardB,
          
          input [31:0] ALU_DATA_WB,
          input [31:0] ALU_OUT_MEM,
          
          output ZERO_EX,
          output [31:0] ALU_OUT_EX,
          output [31:0] PC_Branch_EX,
          output [31:0] REG_DATA2_EX_FINAL
          );
    
    wire [3:0] ALUinput;
    wire [31:0] DATA1_MUX3, DATA2_MUX2;
    
    ALUcontrol ALU_CONTROL(ALUop_EX, FUNCT7_EX, FUNCT3_EX, ALUinput);
    
    ALU ALU_INST(ALUinput, DATA1_MUX3, DATA2_MUX2, ZERO_EX, ALU_OUT_EX);
    
    adder ADDER(PC_EX, IMM_EX, PC_Branch_EX);
    
    mux_3_1 MUX311(REG_DATA1_EX, ALU_DATA_WB, ALU_OUT_MEM, forwardA, DATA1_MUX3);
    
    mux_3_1 MUX312(REG_DATA2_EX, ALU_DATA_WB, ALU_OUT_MEM, forwardB, REG_DATA2_EX_FINAL);
    
    mux2_1 MUX21(REG_DATA2_EX_FINAL, IMM_EX, ALUSrc_EX, DATA2_MUX2);
    
endmodule
