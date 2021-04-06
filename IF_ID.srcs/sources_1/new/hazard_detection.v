`timescale 1ns / 1ps

module hazard_detection(input [4:0] rd,
                        input [4:0] rs1,
                        input [4:0] rs2,
                        input MemRead,
                        output reg PCwrite,
                        output reg IF_IDwrite,
                        output reg control_sel);
    
    always @(*) begin
        if (MemRead == 1 && (rd == rs1 || rd == rs2))
            {PCwrite, IF_IDwrite, control_sel} = 3'b001;
        else
            {PCwrite, IF_IDwrite, control_sel} = 3'b110;
    end
    
endmodule