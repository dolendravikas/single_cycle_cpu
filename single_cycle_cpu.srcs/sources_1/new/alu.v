`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dolendra Vikas Addepalli
// 
// Create Date: 25.09.2023 18:07:32
// Design Name: 
// Module Name: alu
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


module alu_one_bit(A, B, CIN, LESS, AINV, BINV, Opr, RESULT, COUT, ADD_R);
    input A, B, CIN, LESS, AINV, BINV;
    input [1:0] Opr;
    output RESULT, ADD_R, COUT;
    
    reg RESULT, COUT, ADD_R;
             
    always @(*) 
    begin  : combinational_logic // named procedural block
        // local declarations in the named procedural block
        reg RESULT_AND, RESULT_OR, RESULT_ADD_SUB, RESULT_SLT;
        reg Am, Bm; // Am is the A at the output of the mux controlled by AINV; Similarly Bm
  
        Am = AINV ? ~A : A;  
        Bm = BINV ? ~B : B;
        RESULT_AND =  Am & Bm;
        RESULT_OR  =  Am | Bm;
        ADD_R = Am ^ Bm ^ CIN;
        RESULT_ADD_SUB = ADD_R;
        RESULT_SLT = LESS;
        COUT   = (Am & Bm)^(Bm & CIN)^(Am & CIN);
        case (Opr)
                0: begin // 2'b00 Logical AND Function
                    RESULT = RESULT_AND; 
                end
                1: begin // 2'b01 Logical OR Function
                    RESULT = RESULT_OR; 
                end 
                2: begin // 2'b10 Arithmatic addition or subtract depending on the value of BINV
                    RESULT = RESULT_ADD_SUB;
                end
                3: begin // 2'b11 for the SLT A, B instruction ( if A < B, RESULT =1)
                    RESULT = RESULT_SLT;
                end                        
        endcase
    end 
endmodule

module alu(A, B, AINV, BNEG, Opr, RESULT, OVERFLOW, ZERO, COUT);
    parameter nbit = 32; //size of an ALU
    input [nbit-1:0] A, B;
    input  AINV, BNEG;
    input [1:0] Opr;
    
    output[nbit-1:0] RESULT;
    output OVERFLOW, ZERO, COUT;
    
    //LOCAL SIGNALS;
    wire [nbit-1:0] COUTN;
    wire BINV, SET, LESS_0;
    wire [nbit-1:0] ADD_R;
    
    assign BINV = BNEG;
    assign CIN = BNEG;
    
    assign COUT = COUTN[nbit-1];
    assign OVERFLOW = COUTN[nbit-2] ^ COUTN[nbit-1];
    assign SET = ADD_R[nbit-1];
    assign LESS_0 = (SET&(~OVERFLOW)) | (OVERFLOW&COUT);
    //assign ZERO = 	~( (RESULT[0]) | (RESULT[1]) | (RESULT[2]) | (RESULT[3]) );
    assign ZERO = ~(|RESULT);
    
    // module alu_one_bit (A, B, CIN, LESS, AINV, BINV, Opr, RESULT, COUT, ADD_R);
    alu_one_bit alu0 (A[0], B[0], CIN, LESS_0, AINV, BINV, Opr, RESULT[0], COUTN[0], ADD_R[0]);    
    generate
        for(genvar i = 1; i<32; i = i+1) begin
            alu_one_bit alu1 (A[i], B[i], COUTN[i-1], 1'b0, AINV, BINV, Opr, RESULT[i], COUTN[i], ADD_R[i]);
        end
    endgenerate
endmodule
