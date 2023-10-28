`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dolendra Vikas Addepalli
// 
// Create Date: 24.09.2023 22:26:13
// Design Name: 
// Module Name: control_unit
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


module control_unit(opcode, regdst, branch, memread, memtoreg, aluop, memwrite, alusrc, regwrite, jump, jr, jal);
    input [5:0] opcode;
    output reg regdst, branch, memread, memtoreg, memwrite, alusrc, regwrite, jump, jr, jal;
    output reg [1:0] aluop;
    
    always@(opcode)
    begin
        case(opcode)
            6'b000000: begin // R-format instruction
                branch = 0;
                jump = 0; jr = 0; jal = 0;
                regdst = 1; memtoreg = 0; alusrc = 0;
                memread = 0; memwrite = 0; regwrite = 1;
                aluop = 2'b10;            
            end
            6'b001000: begin // Add Immediate instruction
                branch = 0;
                jump = 0; jr = 0; jal = 0;
                regdst = 0; alusrc = 1; memtoreg = 0;
                memread = 0; memwrite = 0; regwrite = 1;
                aluop = 2'b00;            
            end
            6'b100011: begin // Load Word instruction
                branch = 0;
                jump = 0; jr = 0; jal = 0;
                regdst = 0; alusrc = 1; memtoreg = 1;
                memread = 1; memwrite = 0; regwrite = 1;
                aluop = 2'b00;            
            end
            6'b101011: begin // Store Word instruction
                branch = 0;
                jump = 0; jr = 0; jal = 1'bx;
                regdst = 1'bx; alusrc = 1; memtoreg = 1'bx;
                memread = 0; memwrite = 1; regwrite = 0;
                aluop = 2'b00;            
            end
            6'b000100: begin // Branch On Equal instruction
                branch = 1;
                jump = 0; jr = 0; jal = 1'bx;
                regdst = 1'bx; alusrc = 0; memtoreg = 1'bx;
                memread = 0; memwrite = 0; regwrite = 0;
                aluop = 2'b01;            
            end
            6'b000010: begin // Jump (J) instruction
                branch = 1'bx;
                jump = 1; jr = 0; jal = 1'bx;
                regdst = 1'bx; alusrc = 1'bx; memtoreg = 1'bx;
                memread = 0; memwrite = 0; regwrite = 0;
                aluop = 2'bxx;            
            end
            6'b000011: begin // Jump and Link (JAL) instruction
                branch = 1'bx;
                jump = 1; jr = 0; jal = 1;
                regdst = 1'bx; alusrc = 1'bx; memtoreg = 1'bx;
                memread = 0; memwrite = 0; regwrite = 1;
                aluop = 2'bxx;            
            end
            6'b000001: begin // Jump Register (JR) instruction
                branch = 1'bx;
                jump = 1'bx; jr = 1; jal = 1'bx;
                regdst = 1'bx; alusrc = 1'bx; memtoreg = 1'bx;
                memread = 0; memwrite = 0; regwrite = 0;
                aluop = 2'bxx;            
            end
            default: begin
                branch = 0;
                jump = 0; jr = 0; jal = 0;
                regdst = 0; alusrc = 0; memtoreg = 0;
                memread = 0; memwrite = 0; regwrite = 0;
                aluop = 2'b00;
            end
        endcase
    end
endmodule
