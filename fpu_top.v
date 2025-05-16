`timescale 1ns / 1ps

module fpu_top(
    input clk,
    input [31:0] a,
    input [31:0] b,
    input [1:0] op,
    output [31:0] out
    );

    wire [31:0] operand_a_S1, operand_b_S1;
    wire [1:0] operator_S1;
    
    fpu_fetch fetch (.clk(clk),
                     .in_operand_a(a),
                     .in_operand_b(b),
                     .in_operator(op),
                     .operand_a(operand_a_S1),
                     .operand_b(operand_b_S1),
                     .operator(operator_S1));
    
    wire sign_1_S2, sign_2_S2;
    wire [7:0] exponent_1_S2, exponent_2_S2;
    wire [23:0] mantissa_1_S2, mantissa_2_S2;
    wire [1:0] operator_S2;
    
    fpu_unpack unpack (.clk(clk),
                       .in_operand_a(operand_a_S1),
                       .in_operand_b(operand_b_S1),
                       .in_operator(operator_S1),
                       .sign_1(sign_1_S2),
                       .sign_2(sign_2_S2),
                       .exponent_1(exponent_1_S2),
                       .exponent_2(exponent_2_S2),
                       .mantissa_1(mantissa_1_S2),
                       .mantissa_2(mantissa_2_S2),
                       .operator(operator_S2));
    
    wire sign_1_S3, sign_2_S3;
    wire [7:0] exponent_S3;
    wire [23:0] mantissa_1_S3, mantissa_2_S3;
    wire [1:0] operator_S3;
    
    fpu_align align (.clk(clk),
                     .in_sign_1(sign_1_S2),
                     .in_sign_2(sign_2_S2),
                     .in_exponent_1(exponent_1_S2),
                     .in_exponent_2(exponent_2_S2),
                     .in_mantissa_1(mantissa_1_S2),
                     .in_mantissa_2(mantissa_2_S2),
                     .in_operator(operator_S2),
                     .sign_1(sign_1_S3),
                     .sign_2(sign_2_S3),
                     .exponent(exponent_S3),
                     .mantissa_1(mantissa_1_S3),
                     .mantissa_2(mantissa_2_S3),
                     .operator(operator_S3));

    wire sign_S4;
    wire [7:0] exponent_S4;
    wire [47:0] mantissa_S4;
    wire [1:0] operator_S4;
    
    fpu_compute compute (.clk(clk),
                         .in_sign_1(sign_1_S3),
                         .in_sign_2(sign_2_S3),
                         .in_exponent(exponent_S3),
                         .in_mantissa_1(mantissa_1_S3),
                         .in_mantissa_2(mantissa_2_S3),
                         .in_operator(operator_S3),
                         .sign(sign_S4),
                         .exponent(exponent_S4),
                         .mantissa(mantissa_S4),
                         .operator(operator_S4));
    
    wire out_sign;
    wire [7:0] out_exponent;
    wire [22:0] out_mantissa;
    
    fpu_normalize normalize (.clk(clk),
                             .in_sign(sign_S4),
                             .in_exponent(exponent_S4),
                             .in_mantissa(mantissa_S4),
                             .in_operator(operator_S4),
                             .sign(out_sign),
                             .exponent(out_exponent),
                             .mantissa(out_mantissa));
                             
    assign out = {out_sign, out_exponent, out_mantissa};
                             
endmodule
