`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2020 11:00:02 PM
// Design Name: 
// Module Name: EX_MEM_reg
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


module EX_MEM_reg(
        input clk, write, reset,
        input [4:0] RD_EX,
        input RegWrite_EX,
        input MemtoReg_EX,
        input MemRead_EX,
        input MemWrite_EX,
        input Branch_EX,
        input ZERO_EX,
        input [31:0] ALU_OUT_EX,
        input [31:0] PC_Branch_EX,
        input [31:0] REG_DATA2_EX_FINAL,
        output reg [4:0] RD_MEM,
        output reg RegWrite_MEM,
        output reg MemtoReg_MEM,
        output reg MemRead_MEM,
        output reg MemWrite_MEM,
        output reg Branch_MEM,
        output reg ZERO_MEM,
        output reg [31:0] ALU_OUT_MEM,
        output reg [31:0] PC_Branch_MEM,
        output reg [31:0] REG_DATA2_MEM_FINAL        
    );
    
    always@(posedge clk) begin
        if (reset) begin
            RD_MEM <= 0;
            RegWrite_MEM <= 0;
            MemtoReg_MEM <= 0;
            MemRead_MEM <= 0;
            MemWrite_MEM <= 0;
            Branch_MEM <= 0;
            ZERO_MEM <= 0;
            ALU_OUT_MEM <= 0;
            PC_Branch_MEM <= 0;
            REG_DATA2_MEM_FINAL <= 0;
        end
        else begin
            if(write) begin
                RD_MEM <= RD_EX;
                RegWrite_MEM <= RegWrite_EX;
                MemtoReg_MEM <= MemtoReg_EX;
                MemRead_MEM <= MemRead_EX;
                MemWrite_MEM <= MemWrite_EX;
                Branch_MEM <= Branch_EX;
                ZERO_MEM <= ZERO_EX;
                ALU_OUT_MEM <= ALU_OUT_EX;
                PC_Branch_MEM <= PC_Branch_EX;
                REG_DATA2_MEM_FINAL <= REG_DATA2_EX_FINAL;
            end
        end
    end
 
endmodule
