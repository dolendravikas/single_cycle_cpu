`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dolendra Vikas Addepalli
// 
// Create Date: 26.09.2023 15:36:27
// Design Name: 
// Module Name: sign_extend
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


module sign_extend(inputsignal, outputsignal);
    input [15:0] inputsignal;
    output [31:0] outputsignal;
    assign outputsignal[15:0] = inputsignal[15:0];
    assign outputsignal[31:16] = inputsignal[15]?16'b1:16'b0;
endmodule
