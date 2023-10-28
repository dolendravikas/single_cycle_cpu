`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dolendra Vikas Addepalli
// 
// Create Date: 26.09.2023 15:36:27
// Design Name: 
// Module Name: program_counter
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


module program_counter(pcinput, pcoutput, clk, rst);
    input [31:0] pcinput;
    output reg [31:0] pcoutput;
    input clk,rst;
    always@(posedge clk, posedge rst)
    begin
        if(rst == 1'b1) pcoutput <= 0;
        else pcoutput <= pcinput;
    end
endmodule
