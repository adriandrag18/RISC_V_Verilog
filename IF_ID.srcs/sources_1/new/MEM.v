`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2020 11:50:41 PM
// Design Name: 
// Module Name: MEM
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


module MEM(
    input clk,
    input [4:0] RD_MEM,
    input RegWrite_MEM,
    input MemtoReg_MEM,
    input MemRead_MEM,
    input MemWrite_MEM,
    input Branch_MEM,
    input ZERO_MEM,
    input [31:0] ALU_OUT_MEM,
    input [31:0] PC_Branch_MEM,
    input [31:0] REG_DATA2_FINAL_MEM,
    
    output [31:0]PC_Branch_MEM_OUT,
    output [31:0] ALU_OUT_MEM_OUT, 
    output PCSrc_MEM,
    output [4:0] RD_MEM_OUT,
    output [31:0] READ_DATA
    );
    
    assign PCSrc_MEM = ZERO_MEM & Branch_MEM;
    
    assign PC_Branch_MEM_OUT = PC_Branch_MEM;
    assign ALU_OUT_MEM_OUT = ALU_OUT_MEM;
    assign RD_MEM_OUT = RD_MEM;
    
    data_memory DATA_MEMORY(clk, MemRead_MEM, MemWrite_MEM, 
                            ALU_OUT_MEM, REG_DATA2_FINAL_MEM, READ_DATA);
    
endmodule
