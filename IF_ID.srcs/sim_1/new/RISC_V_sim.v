`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2021 09:42:09 PM
// Design Name: 
// Module Name: RISC_V_sim
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
module RISC_V_sim;
  reg clk, reset;
  wire PCSrc, pipeline_stall;
  wire [1:0] forwardA, forwardB;
  wire [31:0] PC_EX, ALU_OUT_EX,PC_MEM, DATA_MEMORY_MEM, ALU_DATA_WB;
 
  RISC_V procesor(  clk,
                    reset,
              
                    PC_EX,
                    ALU_OUT_EX,
                    PC_MEM,
                    PCSrc,
                    DATA_MEMORY_MEM,
                    ALU_DATA_WB,
                    forwardA, forwardB,
                    pipeline_stall
                      );
  
  always #5 clk=~clk;
  
  initial begin
    #0 clk=1'b0;
       reset=1'b1;       
       
    #10 reset=1'b0;
    #200 $finish;
  end

endmodule