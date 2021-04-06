`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2020 08:36:29 PM
// Design Name: 
// Module Name: ALU
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


module ALU(input [3:0] ALUop,
           input [31:0] ina, inb,
           output zero,
           output reg [31:0] out);
    
    reg aux;
    
    initial begin
        out = 0;
        aux = 1;
    end
    always @(*)begin
        out = 0;
        casex(ALUop)
            4'b0000: out = ina & inb;   // and, andi
            4'b0001: out = ina | inb;   // or, ori
            4'b0010: out = ina + inb;   // add, addi, lw, sd
            4'b0011: out = ina ^ inb;   // xor, xori
            4'b0100: out = ina << inb;  // sll, slli
            4'b0101: out = ina >> inb;  // srl, srli
            4'b0110: out = ina - inb;   // sub, subi, beg, bne
            4'b1001: out = ina >>> inb; // sra, srai
            4'b0111:                    // bltu, bgeu, sltu, sltiu
                if ({1'b0, ina} > {1'b0, inb})
                    out = 0;
                else
                    out = 1;
            4'b1000:                    // blt, bge, slt, slti
                if (ina > inb)
                    out = 0;
                else
                    out = 1;
            default: out = 0;
        endcase
        if (out == 0)
            aux = 1;
        else
            aux = 0;
    end
    
    assign zero = aux; 
    
endmodule
