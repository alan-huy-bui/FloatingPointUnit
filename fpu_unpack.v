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
    
    wire sign_a, sign_b;
    wire [7:0] exponent_a, exponent_b;
    wire [22:0] mantissa_a, mantissa_b;
    
    assign sign_a = in_operand_a[31];
    assign sign_b = in_operand_b[31];
    assign exponent_a = in_operand_a[30:23];
    assign exponent_b = in_operand_b[30:23];
    assign mantissa_a = in_operand_a[22:0];
    assign mantissa_b = in_operand_b[22:0];
    
    always @ (*) begin
        //  TODO: Check Exceptions
        case (in_operator)
            
            2'b00: begin
            
                //  If |A| < |B|, Then B + A
                if ((exponent_a < exponent_b) || ((exponent_a == exponent_b) && (mantissa_a < mantissa_b))) begin
                    larger_sign = sign_b;
                    larger_exponent = exponent_b;
                    larger_mantissa = {1'b1, mantissa_b};
                    smaller_sign = sign_a;
                    smaller_exponent = exponent_a;
                    smaller_mantissa = {1'b1, mantissa_a};
                
                //  If |A| >= |B|, Then A + B
                end else begin
                    larger_sign = sign_a;
                    larger_exponent = exponent_a;
                    larger_mantissa = {1'b1, mantissa_a};
                    smaller_sign = sign_b;
                    smaller_exponent = exponent_b;
                    smaller_mantissa = {1'b1, mantissa_b};
                end
            end
            
            2'b01 : begin

                //  If |A| < |B|, Then -B + A
                if ((exponent_a < exponent_b) || ((exponent_a == exponent_b) && (mantissa_a < mantissa_b))) begin
                    larger_sign = ~sign_b;
                    larger_exponent = exponent_b;
                    larger_mantissa = {1'b1, mantissa_b};
                    smaller_sign = sign_a;
                    smaller_exponent = exponent_a;
                    smaller_mantissa = {1'b1, mantissa_a};
                    
                //  If |A| >= |B|, Then A + -B
                end else begin
                    larger_sign = sign_a;
                    larger_exponent = exponent_a;
                    larger_mantissa = {1'b1, mantissa_a};
                    smaller_sign = ~sign_b;
                    smaller_exponent = exponent_b;
                    smaller_mantissa = {1'b1, mantissa_b};
                end
                
            end
            
            default : begin

                larger_sign = sign_a;
                larger_exponent = exponent_a;
                larger_mantissa = {1'b1, mantissa_a};
                smaller_sign = sign_b;
                smaller_exponent = exponent_b;
                smaller_mantissa = {1'b1, mantissa_b};
                
            end
        endcase
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
