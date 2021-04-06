`timescale 1ns / 1ps

module data_memory(input clk,       
                   input mem_read,
                   input mem_write,
                   input [31:0] address,
                   input [31:0] write_data,
                   output reg [31:0] read_data
                   );
    reg [31:0] Memory [0:1023], addr;
                   
    integer i;
    initial begin
        for (i = 0; i < 1024; i = i + 1)
            Memory[i] = 0;
    end
   
    always@(*) begin
        addr = address >> 2;
        if (mem_read)
            read_data <= Memory[addr];
    end
    
    always @(posedge clk) begin
        addr = address >> 2;
        if (mem_write)
            Memory[addr] <= write_data;
    end
    
endmodule