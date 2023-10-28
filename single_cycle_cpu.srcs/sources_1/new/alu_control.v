`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dolendra Vikas Addepalli
// 
// Create Date: 25.09.2023 18:07:32
// Design Name: 
// Module Name: alu_control
// Project Name: Single Cycle CPU
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


module alu_control(aluop, alufunction, aluselect);
    input [1:0] aluop;
    input [5:0] alufunction;
    output reg [3:0] aluselect;
    
    always@(*)
    begin
        if(aluop == 2'b10) begin
            case(alufunction)
                6'b100000: aluselect = 4'b0010; //add
                6'b100010: aluselect = 4'b0110; //sub
                6'b100100: aluselect = 4'b0000; //and
                6'b100101: aluselect = 4'b0001; //or
                6'b100110: aluselect = 4'b1100; //nor
                6'b100111: aluselect = 4'b1101; //nand
                6'b101010: aluselect = 4'b0111; //slt                
            endcase
        end
    end
endmodule
