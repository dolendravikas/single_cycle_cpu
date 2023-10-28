`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dolendra Vikas Addepalli
// 
// Create Date: 26.09.2023 15:37:26
// Design Name: 
// Module Name: mux_32bit
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


module mux_32bit(input0, input1, result, select);
    input [31:0] input0, input1;
    input select;
    output [31:0] result;
    assign result = select?input1:input0;
endmodule
