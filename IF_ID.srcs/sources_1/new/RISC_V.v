`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2020 12:33:01 AM
// Design Name: 
// Module Name: RISC_V
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

module RISC_V(input clk,
              input reset,
              
              output [31:0] PC_EX,
              output [31:0] ALU_OUT_EX,
              output [31:0] PC_MEM,
              output PCSrc,
              output [31:0] DATA_MEMORY_MEM,
              output [31:0] ALU_DATA_WB,
              output [1:0] forwardA, forwardB,
              output pipeline_stall
             );
    
    wire write, PC_write, RegWrite_WB, control_sel, RegWrite_ID, MemtoReg_ID, MemRead_ID;
    wire MemWrite_ID, ALUSrc_ID, Branch_ID;
    wire [2:0] FUNCT3_ID, ALUop_ID;
    wire [4:0] RD_WB, RS1_ID, RS2_ID, RD_ID;
    wire [6:0] FUNCT7_ID, OPCODE_ID;
    wire [31:0] PC_Branch, PC_ID, INSTRUCTION_ID, IMM_ID, REG_DATA1_ID, REG_DATA2_ID;
    wire RegWrite_MEM;
    wire [4:0] ex_mem_rd, mem_wb_rd;
    
    RISC_V_IF_ID IF_ID(.clk(clk), 
                       .reset(reset),
                       .IF_ID_write(write),
                       .PCSrc(PCSrc), .PC_write(PC_write),
                       .PC_Branch(PC_Branch),
                       .RegWrite_WB(RegWrite_WB),
                       .ALU_DATA_WB(ALU_DATA_WB),
                       .RD_WB(mem_wb_rd),
                       .control_sel(control_sel),
                       .PC_ID(PC_ID),
                       .INSTRUCTION_ID(INSTRUCTION_ID),
                       .IMM_ID(IMM_ID),
                       .REG_DATA1_ID(REG_DATA1_ID),
                       .REG_DATA2_ID(REG_DATA2_ID),
                       .FUNCT3_ID(FUNCT3_ID),
                       .FUNCT7_ID(FUNCT7_ID),
                       .OPCODE_ID(OPCODE_ID),
                       .RD_ID(RD_ID),
                       .RS1_ID(RS1_ID),
                       .RS2_ID(RS2_ID),
                       .RegWrite_ID(RegWrite_ID),
                       .MemtoReg_ID(MemtoReg_ID),
                       .MemRead_ID(MemRead_ID),
                       .MemWrite_ID(MemWrite_ID),
                       .ALUop_ID(ALUop_ID),
                       .ALUSrc_ID(ALUSrc_ID),
                       .Branch_ID(Branch_ID)); 

     wire MemRead_EX;
     wire [4:0] RD_EX;
     
     hazard_detection HAZARD_DETECTION(.rd(RD_EX),
                                       .rs1(RS1_ID), 
                                       .rs2(RS2_ID),
                                       .MemRead(MemRead_EX), 
                                       .PCwrite(PC_write),
                                       .IF_IDwrite(write),
                                       .control_sel(control_sel));
    
    wire RegWrite_EX, MemtoReg_EX, MemWrite_EX, ALUSrc_EX, Branch_EX;
    wire [2:0] FUNCT3_EX, ALUop_EX;
    wire [4:0] RS1_EX, RS2_EX;
    wire [6:0] OPCODE_EX, FUNCT7_EX;
    wire [31:0] IMM_EX, REG_DATA1_EX, REG_DATA2_EX;
    
    ID_EX_reg ID_EX_REG(.clk(clk), .write(write), .reset(reset),
                        .IMM_ID(IMM_ID),
                        .REG_DATA1_ID(REG_DATA1_ID), .REG_DATA2_ID(REG_DATA2_ID),
                        .FUNCT3_ID(FUNCT3_ID),
                        .FUNCT7_ID(FUNCT7_ID),
                        .OPCODE_ID(OPCODE_ID),
                        .RD_ID(RD_ID),
                        .RS1_ID(RS1_ID),
                        .RS2_ID(RS2_ID),
                        .RegWrite_ID(RegWrite_ID), .MemtoReg_ID(MemtoReg_ID),
                        .MemRead_ID(MemRead_ID), .MemWrite_ID(MemWrite_ID),
                        .ALUop_ID(ALUop_ID),
                        .ALUSrc_ID(ALUSrc_ID), .Branch_ID(Branch_ID),
                        .PC_ID(PC_ID),
                        .IMM_EX(IMM_EX),
                        .REG_DATA1_EX(REG_DATA1_EX), .REG_DATA2_EX(REG_DATA2_EX),
                        .FUNCT3_EX(FUNCT3_EX),
                        .FUNCT7_EX(FUNCT7_EX),
                        .OPCODE_EX(OPCODE_EX),
                        .RD_EX(RD_EX),
                        .RS1_EX(RS1_EX),
                        .RS2_EX(RS2_EX),
                        .RegWrite_EX(RegWrite_EX), .MemtoReg_EX(MemtoReg_EX),
                        .MemRead_EX(MemRead_EX), .MemWrite_EX(MemWrite_EX),
                        .ALUop_EX(ALUop_EX),
                        .ALUSrc_EX(ALUSrc_EX), .Branch_EX(Branch_EX),
                        .PC_EX(PC_EX));
    
    
    
    forwarding FORWORDING(.rs1(RS1_EX),
                          .rs2(RS2_EX),
                          .ex_mem_rd(ex_mem_rd),
                          .mem_wb_rd(mem_wb_rd),
                          .ex_mem_regwrite(RegWrite_MEM),
                          .mem_wb_regwrite(RegWrite_WB),
                          .forwardA(forwardA), .forwardB(forwardB));
    
    wire ZERO_EX;
    wire [31:0] ALU_OUT_MEM, PC_Branch_EX, REG_DATA2_EX_FINAL;
                                         
    EX execute(.IMM_EX(IMM_EX),         
               .REG_DATA1_EX(REG_DATA1_EX),
               .REG_DATA2_EX(REG_DATA2_EX),
               .PC_EX(PC_EX),
               .FUNCT3_EX(FUNCT3_EX),
               .FUNCT7_EX(FUNCT7_EX),
               .RD_EX(RD_EX),
               .RS1_EX(RS1_EX),
               .RS2_EX(RS2_EX),
               .RegWrite_EX(RegWrite_EX),
               .MemtoReg_EX(MemtoReg_EX),
               .MemRead_EX(MemRead_EX),
               .MemWrite_EX(MemWrite_EX),
               .ALUop_EX(ALUop_EX),
               .ALUSrc_EX(ALUSrc_EX),
               .Branch_EX(Branch_EX),
               .forwardA(forwardA), .forwardB(forwardB),
               .ALU_DATA_WB(ALU_DATA_WB),
               .ALU_OUT_MEM(ALU_OUT_MEM),
               .ZERO_EX(ZERO_EX),
               .ALU_OUT_EX(ALU_OUT_EX),
               .PC_Branch_EX(PC_Branch_EX),
               .REG_DATA2_EX_FINAL(REG_DATA2_EX_FINAL));

    wire MemtoReg_MEM, MemRead_MEM, MemWrite_MEM, Branch_MEM, ZERO_MEM;
    wire [31:0] REG_DATA2_MEM_FINAL;

    EX_MEM_reg EX_MEM_REG(.clk(clk), .write(write), .reset(reset),
                          .RD_EX(RD_EX),
                          .RegWrite_EX(RegWrite_EX),
                          .MemtoReg_EX(MemtoReg_EX),
                          .MemRead_EX(MemRead_EX),
                          .MemWrite_EX(MemWrite_EX),
                          .Branch_EX(Branch_EX),
                          .ZERO_EX(ZERO_EX),
                          .ALU_OUT_EX(ALU_OUT_EX),
                          .PC_Branch_EX(PC_Branch_EX),
                          .REG_DATA2_EX_FINAL(REG_DATA2_EX_FINAL),
                          .RD_MEM(ex_mem_rd),
                          .RegWrite_MEM(RegWrite_MEM),
                          .MemtoReg_MEM(MemtoReg_MEM),
                          .MemRead_MEM(MemRead_MEM),
                          .MemWrite_MEM(MemWrite_MEM),
                          .Branch_MEM(Branch_MEM),
                          .ZERO_MEM(ZERO_MEM),
                          .ALU_OUT_MEM(ALU_OUT_MEM),
                          .PC_Branch_MEM(PC_MEM),
                          .REG_DATA2_MEM_FINAL(REG_DATA2_MEM_FINAL));

    wire [4:0] RD_MEM_OUT;
    wire [31:0] PC_Branch_MEM_OUT, ALU_OUT_MEM_OUT, READ_DATA;
    
    MEM memory(.clk(clk),
               .RD_MEM(ex_mem_rd),
               .RegWrite_MEM(RegWrite_MEM),
               .MemtoReg_MEM(MemtoReg_MEM),
               .MemRead_MEM(MemRead_MEM),
               .MemWrite_MEM(MemWrite_MEM),
               .Branch_MEM(Branch_MEM),
               .ZERO_MEM(ZERO_MEM),
               .ALU_OUT_MEM(ALU_OUT_MEM),
               .PC_Branch_MEM(PC_MEM),
               .REG_DATA2_FINAL_MEM(REG_DATA2_MEM_FINAL),
               .PC_Branch_MEM_OUT(PC_Branch_MEM_OUT),
               .ALU_OUT_MEM_OUT(ALU_OUT_MEM_OUT), 
               .PCSrc_MEM(PCSrc),
               .RD_MEM_OUT(RD_MEM_OUT),
               .READ_DATA(DATA_MEMORY_MEM));
    
    wire MemtoReg_WB, PCSrc_WB;
    wire [31:0] ALU_OUT_WB, READ_DATA_WB;
    
    MEM_WB_reg MEM_WB_REG(.clk(clk), .write(write), .reset(reset),
               .RegWrite_MEM(RegWrite_MEM),
               .MemtoReg_MEM(MemtoReg_MEM),
               .ALU_OUT_MEM(ALU_OUT_MEM),
               .RD_MEM(RD_MEM_OUT),
               .READ_DATA(DATA_MEMORY_MEM),
               .RegWrite_WB(RegWrite_WB),
               .MemtoReg_WB(MemtoReg_WB),
               .ALU_OUT_WB(ALU_OUT_WB),
               .RD_WB(mem_wb_rd),
               .READ_DATA_WB(READ_DATA_WB));
    
    mux2_1 write_back(ALU_OUT_WB,
                      READ_DATA_WB,
                      MemtoReg_WB,
                      ALU_DATA_WB);
    
    assign pipeline_stall = control_sel;
    
endmodule