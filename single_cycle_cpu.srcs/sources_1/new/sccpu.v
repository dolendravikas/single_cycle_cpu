`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dolendra Vikas Addepalli
// 
// Create Date: 24.09.2023 22:21:07
// Design Name: 
// Module Name: sccpu
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


module sccpu(clk, rst);
    input clk, rst;
    
    wire regdst, branch, memread, memtoreg, memwrite, alusrc, regwrite, jump, jr, jal; //cpu signals;
    wire [1:0] aluop;
    wire [31:0] pc; //program counter
    wire [31:0] pc_nxt; //address of the next instruction to be accessed
    
    wire [31:0] instruction; //32-bit MIPS instruction;
    wire [4:0] reg_write_address; //output of the regdst mux
    wire [4:0] reg_write_address_jal; //output of the JAL mux
    wire [31:0] reg_write_data; //data to be written in the register file
    
    wire [31:0] readData1, readData2; //output data wires for the register file
    wire [31:0] signExtend_output; //output of the sign extender
    wire [31:0] alusrc_mux_output; //output of the alusrc mux
    
    wire [3:0] alucontrol_output; //ALU control output, alu select
    wire [31:0] aluResult; //output of the ALU
    wire zero, overflow, cout; //overflow and cout are not used in the design currently
    
    wire [31:0] shiftLeft2BeqOut;// output of the shift left2 block
    wire [31:0] beqALUoutput;// output of the beq address addition alu
    
    wire [31:0] readData_datamemory; //output of the data memory    
    wire [31:0] memtoreg_mux_output; //output of the memtoreg multiplexer
    
    wire [27:0] shiftLeft2JOut; //output of the shift left2 Jump block
    wire [31:0] branchMuxOutput; //output of the branch multiplexer
    wire [31:0] jumpMuxOutput; //output of the jump multiplexer
    wire [31:0] jrMuxOutput; //output of the jr multiplexer
    
    wire [31:0] pc_4; //program counter after incrementing by 4
    
    assign pc_4 = pc+4;
    
    program_counter pcregister(jrMuxOutput[31:0], pc[31:0], clk, rst);
    instruction_memory instructionMemory(pc[31:0], instruction[31:0], clk, rst);
    assign reg_write_address[4:0] = regdst?instruction[15:11]:instruction[20:16];
    assign reg_write_address_jal[4:0] = jal?5'b1:reg_write_address[4:0];
    assign reg_write_data[31:0] = jal?(pc_4):memtoreg_mux_output[31:0];
    register_file registerFile(instruction[25:21], instruction[20:16], readData1, readData2, reg_write_address_jal, reg_write_data, regwrite, clk, rst);
    sign_extend signExtend(instruction[15:0],signExtend_output[31:0]);
    assign alusrc_mux_output[31:0] = alusrc?signExtend_output[31:0]:readData2[31:0];
    alu_control ALUcontrol(aluop[1:0], instruction[5:0], alucontrol_output[3:0]);
    alu ALU(readData1, readData2, alucontrol_output[3], alucontrol_output[2], alucontrol_output[1:0], aluResult[31:0], overflow, zero, cout);
    data_memory dataMemory(memread, memwrite, aluResult[31:0], readData2[31:0], readData_datamemory[31:0], clk, rst);
    assign memtoreg_mux_output[31:0] = memtoreg?readData_datamemory[31:0]:aluResult[31:0];
    control_unit controlUnit(instruction[31:26], regdst, branch, memread, memtoreg, aluop, memwrite, alusrc, regwrite, jump, jr, jal);
    shift_left2_beq shiftLeft2Beq(signExtend_output[31:0], shiftLeft2BeqOut[31:0]);
    alu_add aluAdd((pc_4), shiftLeft2BeqOut[31:0], beqALUoutput[31:0]);
    assign branchMuxOutput[31:0] = (branch && zero)?beqALUoutput[31:0]:(pc_4);
    shift_left2_j shiftLeft2J(instruction[25:0], shiftLeft2JOut[27:0]);
    assign jumpMuxOutput[31:0] = jump?({pc_4[31:28],shiftLeft2JOut[27:0]}):branchMuxOutput[31:0];
    assign jrMuxOutput[31:0] = jr?readData1[31:0]:jumpMuxOutput[31:0];
        
endmodule
