`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dolendra Vikas Addepalli
// 
// Create Date: 26.09.2023 15:36:27
// Design Name: 
// Module Name: shift_left2_j
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


module shift_left2_j(inputaddress, outputaddress);
    input [25:0] inputaddress;
    output [27:0] outputaddress;
    assign outputaddress[27:0] = {inputaddress[25:0],2'b00};
endmodule
