`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dolendra Vikas Addepalli
// 
// Create Date: 25.09.2023 11:05:12
// Design Name: 
// Module Name: instruction_memory
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


    module instruction_memory(address, instruction, clk, rst);
    input clk,rst;
    input [31:0] address;
    output [31:0] instruction;
    
    parameter instructionmemory_size = 1024; // 1KB of instruction memory
    reg [31:0] instructionmemory[instructionmemory_size-1:0];
    
    integer i;
    
    assign instruction = instructionmemory[address>>2];
    
    initial begin
        //Hardcode the instruction memory with instructions
        instructionmemory[0]=32'b000000_00001_00010_00011_00000_100100;       //RTYPE - AND  AND $3, $1, $2;
        instructionmemory[1]=32'b000000_00001_00010_00100_00000_100101;       //RTYPE - OR   OR  $4, $1, $2;
        instructionmemory[2]=32'b000000_00001_00010_00101_00000_100110;       //RTYPE - NOR  NOR $5, $1, $2;  not original mips part  
        instructionmemory[3]=32'b000000_00001_00010_00110_00000_100111;       //RTYPE - NAND NAND $6, $1, $2;  not original mips part
        instructionmemory[4]=32'b000000_00001_00010_00111_00000_100000;       //RTYPE - ADD  ADD $7, $1, $2;  
        instructionmemory[5]=32'b000000_00001_00010_01000_00000_100010;       //RTYPE - SUB  SUB $8, $1, $2;
        instructionmemory[6]=32'b000000_00001_00010_01001_00000_101010;       //RTYPE - SLT  SLT $9, $1, $2;
        instructionmemory[7]=32'b000000_00010_00001_01010_00000_101010;       //RTYPE - SLT  SLT $10, $2, $1;
        
        instructionmemory[8]=32'b100011_00000_01011_00000000_00000100;        //ITYPE - LW   lw $11, 0004($0);
        instructionmemory[9]=32'b101011_00000_01011_00000000_00000100;        //ITYPE - SW   sw $11, 0004($0);

        instructionmemory[10]=32'b000010_00000000_00000000_00000101_00;       //JTYPE - JUMP j 80; 

        instructionmemory[20]=32'b000100_00000_00011_11111111_1110_1011;      //ITYPE - BEQ  beq $0, $3, go to initial position
    end

//    initial begin
//        for(i = 0; i < 1024; i = i + 1) begin
//            instructionmemory[i] = i;
//        end
//    end
    
//    always@(posedge clk, posedge rst) 
//    begin
//        if(rst == 1'b1) begin
//            for(i = 0; i < 1024; i = i + 1) begin
//                instructionmemory[i] <= 32'b0;
//            end
//        end
//    end
endmodule