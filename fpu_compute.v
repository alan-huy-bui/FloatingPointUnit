`timescale 1ns / 1ps

module fpu_compute(
    input clk,
    input in_sign_1,
    input in_sign_2,
    input [7:0] in_exponent,
    input [23:0] in_mantissa_1,
    input [23:0] in_mantissa_2,
    input [1:0] in_operator,
    output reg sign,
    output reg [7:0] exponent,
    output reg [47:0] mantissa,
    output reg [1:0] operator
    );
    
    reg [47:0] computed_mantissa;
    reg computed_sign;
    
    always @ (*) begin
        case (in_operator)
            2'b00: begin
                computed_mantissa = in_mantissa_1 + in_mantissa_2;
                computed_sign = 0;  // TODO
            end
            
            2'b10: begin
                computed_mantissa = in_mantissa_1 * in_mantissa_2;
                computed_sign =  in_sign_1 ^ in_sign_2;
            end
            
            default: begin
                computed_mantissa = 0;
                computed_sign = 0;
            end
        endcase
    end
    
    always @ (posedge clk) begin
        sign <= computed_sign;
        exponent <= in_exponent;
        mantissa <= computed_mantissa;
        operator <= in_operator;
    end
    
endmodule
