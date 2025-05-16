`timescale 1ns / 1ps

module fpu_fetch(
    input clk,
    input [31:0] in_operand_a,
    input [31:0] in_operand_b,
    input [1:0] in_operator,
    output reg [31:0] operand_a,
    output reg [31:0] operand_b,
    output reg [1:0] operator
    );
    
    always @ (posedge clk) begin
        operand_a <= in_operand_a;
        operand_b <= in_operand_b;
        operator <= in_operator;
    end
    
endmodule
