`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2020 11:15:35 PM
// Design Name: 
// Module Name: mux_3_1
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


module mux_3_1(
    input [31:0] in_a,
    input [31:0] in_b,
    input [31:0] in_c,
    input [1:0] sel,
    output [31:0] out
    );
    
    assign out = sel[1] == 1'b1 ? in_c : (sel[0] == 1'b1 ? in_b : in_a);

endmodule
