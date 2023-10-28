`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dolendra Vikas Addepalli
// 
// Create Date: 25.09.2023 11:06:44
// Design Name: 
// Module Name: data_memory
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


module data_memory(memread, memwrite, address, writedata, readdata, clk, rst);
    input memread, memwrite, clk, rst;
    input [31:0] address, writedata;
    output [31:0] readdata;
    
    parameter datamemory_size = 1024; // 1KB of data memory
    reg [31:0] datamemory[datamemory_size-1:0];
    
    assign readdata = (memread)?datamemory[address]:32'bz;
    
    initial begin
    //Hardcode the data memory with some values
        datamemory[0] = 32'b0000_0000_0000_0000_0000_0000_0000_0000; // Decimal 0
        datamemory[1] = 32'b0000_0000_0000_0000_0000_0000_1010_0101; // Decimal 165
        datamemory[2] = 32'b0000_0000_0000_0000_0000_0000_0000_0001; // Decimal 1
        datamemory[3] = 32'b0000_0000_0000_0000_0000_0000_0000_0010; // Decimal 2
        datamemory[4] = 32'b0000_0000_0000_0000_0000_0000_0000_0011; // Decimal 3
        datamemory[5] = 32'b0000_0000_0000_0000_0000_0000_0000_0100; // Decimal 4
    end
    
    always@(posedge clk)
    begin
//        if (rst == 1'b1) begin
//            for(i = 0; i < 1024; i = i+1) begin
//                datamemory[i] <= 32'b0;
//            end
//        end else 
        if(memwrite == 1'b1) begin
            datamemory[address] <= writedata;
        end
    end
endmodule
