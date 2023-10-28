`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dolendra Vikas Addepalli
// 
// Create Date: 28.09.2023 11:25:01
// Design Name: 
// Module Name: sccpu_tb
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


module sccpu_tb();
    reg clk, rst;
    sccpu SingleCycleCPU(clk, rst);
    
    initial begin
        clk = 0;
        rst = 0;
        #1 rst = 1;
        #10 rst = 10;
        #400 $finish;        
    end
    always #5 clk = ~clk;
endmodule
