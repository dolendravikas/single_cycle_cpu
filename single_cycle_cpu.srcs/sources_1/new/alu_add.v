`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dolendra Vikas Addepalli// 
//
// Create Date: 25.09.2023 18:07:32
// Design Name: 
// Module Name: alu_add
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


module alu_add(input1, input2, result);
    input [31:0] input1, input2;
    output [31:0] result;
    assign result = input1+input2;
endmodule
