`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2020 11:00:02 PM
// Design Name: 
// Module Name: MEM_WB_red
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


module MEM_WB_reg(
        input clk, write, reset,
        input RegWrite_MEM,
        input MemtoReg_MEM,
        input [31:0] ALU_OUT_MEM,
        input [4:0] RD_MEM,
        input [31:0] READ_DATA,
        output reg RegWrite_WB,
        output reg MemtoReg_WB,
        output reg [31:0] ALU_OUT_WB,
        output reg [4:0] RD_WB,
        output reg [31:0] READ_DATA_WB
    );
    
     always@(posedge clk) begin
        if (reset) begin
            RegWrite_WB <= 0;
            MemtoReg_WB <= 0;
            ALU_OUT_WB <= 0;
            RD_WB <= 0;
            READ_DATA_WB <= 0;
        end
        else begin
            if(write) begin
                RegWrite_WB <= RegWrite_MEM;
                MemtoReg_WB <= MemtoReg_MEM;
                ALU_OUT_WB <= ALU_OUT_MEM;
                RD_WB <= RD_MEM;
                READ_DATA_WB <= READ_DATA;
            end
        end
    end
    
endmodule
