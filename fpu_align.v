`timescale 1ns / 1ps

module fpu_align(
    input clk,
    input in_sign_1,
    input in_sign_2,
    input [7:0] in_exponent_1,
    input [7:0] in_exponent_2,
    input [23:0] in_mantissa_1,
    input [23:0] in_mantissa_2,
    input [1:0] in_operator,
    output reg sign_1,
    output reg sign_2,
    output reg [7:0] exponent,
    output reg [23:0] mantissa_1,
    output reg [23:0] mantissa_2,
    output reg [1:0] operator
    );
    
    reg [23:0] shifted_mantissa;
    reg [7:0] modified_exponent;
    
    always @ (*) begin
        case (in_operator)
            2'b00: begin
                shifted_mantissa = in_mantissa_2 >> (in_exponent_1 - in_exponent_2);
                modified_exponent = in_exponent_1;
            end
            
            2'b10: begin
                shifted_mantissa = mantissa_2;
                modified_exponent = in_exponent_1 + in_exponent_2;
            end
            
            default: begin
                shifted_mantissa = 0;
                modified_exponent = 0;
            end
        endcase
    end
    
    always @ (posedge clk) begin
        sign_1 <= in_sign_1;
        sign_2 <= in_sign_2;
        exponent = modified_exponent;
        mantissa_1 <= in_mantissa_1;
        mantissa_2 <= shifted_mantissa;
        operator <= in_operator;
    end
    
endmodule
