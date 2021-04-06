`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2020 04:23:45 PM
// Design Name: 
// Module Name: ALUcontrol
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


module ALUcontrol(
    input [1:0] ALUop,
    input[6:0] funct7,
    input [2:0] funct3,
    output reg [3:0] ALUinput
    );
   
    always @(ALUop or funct7 or funct3)begin
        case (ALUop)
            2'b00: ALUinput <= 4'b0010; //ld sd
            2'b01: begin
                case (funct3)
                  3'b000: ALUinput <= 4'b0110; //beq
                  3'b001: ALUinput <= 4'b0110; //bne
                  3'b100: ALUinput <= 4'b1000; //blt
                  3'b101: ALUinput <= 4'b1000; //bge
                  3'b110: ALUinput <= 4'b0111; //bltu
                  3'b111: ALUinput <= 4'b0111; //bgeu
                endcase
            end
            2'b10: begin
                casex ({funct7,funct3})
                  10'b0000000000: ALUinput <= 4'b0010; //add
                  10'b0100000000: ALUinput <= 4'b0110; //sub
                  10'b0000000111: ALUinput <= 4'b0000; //and
                  10'b0000000110: ALUinput <= 4'b0001; //or
                  10'b0000000100: ALUinput <= 4'b0011; //xor
                  10'b0000000101: ALUinput <= 4'b0101; //srl
                  10'b0000000001: ALUinput <= 4'b0100; //sll
                  10'b0100000101: ALUinput <= 4'b1001; //sra
                  10'b0000000011: ALUinput <= 4'b0111; //sltu
                  10'b0000000010: ALUinput <= 4'b1000; //slt
                endcase
            end
            2'b11: begin
                casex({funct7,funct3})
                  10'b0000000001: ALUinput <= 4'b0100; //slli
                  10'b0000000101: ALUinput <= 4'b0101; //srli
                  10'b0100000101: ALUinput <= 4'b1001; //srai
                  10'bxxxxxxx000: ALUinput <= 4'b0010; //addi
                  10'bxxxxxxx010: ALUinput <= 4'b1000; //slti
                  10'bxxxxxxx011: ALUinput <= 4'b0111; //sltiu
                  10'bxxxxxxx100: ALUinput <= 4'b0011; //xori
                  10'bxxxxxxx110: ALUinput <= 4'b0001; //ori
                  10'bxxxxxxx111: ALUinput <= 4'b0000; //andi
                endcase   
            end
        endcase
    end
endmodule

