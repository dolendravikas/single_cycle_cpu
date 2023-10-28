`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dolendra Vikas Addepalli
// 
// Create Date: 25.09.2023 11:06:44
// Design Name: 
// Module Name: register_file
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


module register_file(readreg1, readreg2, readdata1, readdata2, writereg, writedata, regwrite, clk, rst);
    input regwrite, clk, rst;
    input [4:0] readreg1, readreg2, writereg;
    output [31:0] readdata1, readdata2;
    input [31:0] writedata;
    
    reg [31:0] registers[31:0];
    
    assign readdata1 = registers[readreg1];
    assign readdata2 = registers[readreg2];
    
    initial begin
        registers[0] = 32'b0000_0000_0000_0000_0000_0000_0000_0000; // Decimal 0
        registers[1] = 32'b0000_0000_0000_0000_0000_0000_1010_0101; // Decimal 165
        registers[2] = 32'b1111_1111_1111_1111_1111_1111_0101_1010; // Decimal -166
    end
    integer i;
    
    always@(posedge clk, posedge rst)
    begin
        if (rst == 1'b1) begin
            for(i = 0; i < 32; i = i+1) begin
                registers[i] = 32'b0;
            end
        end else if(regwrite == 1'b1) begin
            registers[writereg] = writedata;
        end
    end
endmodule
