`timescale 1ns / 1ps

module fpu_unpack(
    input clk,
    input [31:0] in_operand_a,
    input [31:0] in_operand_b,
    input [1:0] in_operator,
    output reg sign_1,
    output reg sign_2,
    output reg [7:0] exponent_1,
    output reg [7:0] exponent_2,
    output reg [23:0] mantissa_1,
    output reg [23:0] mantissa_2,
    output reg [1:0] operator
    );
    
    reg larger_sign;
    reg smaller_sign;
    reg [7:0] larger_exponent;
    reg [7:0] smaller_exponent;
    reg [23:0] larger_mantissa;
    reg [23:0] smaller_mantissa;
    
    always @ (*) begin
        //  TODO: Check Exceptions
        if (in_operand_a[30:23] >= in_operand_b[30:23]) begin
            larger_sign = in_operand_a[31];
            larger_exponent = in_operand_a[30:23];
            larger_mantissa = {1'b1, in_operand_a[22:0]};
            smaller_sign = in_operand_b[31];
            smaller_exponent = in_operand_b[30:23];
            smaller_mantissa = {1'b1, in_operand_b[22:0]};
        end else begin
            larger_sign = in_operand_b[31];
            larger_exponent = in_operand_b[30:23];
            larger_mantissa = {1'b1, in_operand_b[22:0]};
            smaller_sign = in_operand_a[31];
            smaller_exponent = in_operand_a[30:23];
            smaller_mantissa = {1'b1, in_operand_a[22:0]};
        end
    end
    
    always @ (posedge clk) begin
        sign_1 <= larger_sign;
        exponent_1 <= larger_exponent;
        mantissa_1 <= larger_mantissa;
        sign_2 <= smaller_sign;
        exponent_2 <= smaller_exponent;
        mantissa_2 <= smaller_mantissa;
        operator <= in_operator;
    end
    
endmodule
