`timescale 1ns / 1ps

module tb_fpu_align;
    
    reg clk;
    reg in_sign_1, in_sign_2;
    reg [7:0] in_exponent_1, in_exponent_2;
    reg [23:0] in_mantissa_1, in_mantissa_2;
    reg [1:0] in_operator;
    
    wire sign_1, sign_2;
    wire [7:0] exponent;
    wire [23:0] mantissa_1, mantissa_2;
    wire [1:0] operator;
    
    fpu_align DUT (.clk(clk),
                   .in_sign_1(in_sign_1),
                   .in_sign_2(in_sign_2),
                   .in_exponent_1(in_exponent_1),
                   .in_exponent_2(in_exponent_2),
                   .in_mantissa_1(in_mantissa_1),
                   .in_mantissa_2(in_mantissa_2),
                   .in_operator(in_operator),
                   .sign_1(sign_1),
                   .sign_2(sign_2),
                   .exponent(exponent),
                   .mantissa_1(mantissa_1),
                   .mantissa_2(mantissa_2),
                   .operator(operator));
                   
    initial begin
        clk = 0;
        in_operator = 2'b00;
        
        in_sign_1 = 0;
        in_sign_2 = 0;
        in_exponent_1 = 8'b00000000;
        in_exponent_2 = 8'b00000000;
        in_mantissa_1 = 24'b1_00000000000000000000000;
        in_mantissa_2 = 24'b1_00000000000000000000000;
        #2
        
        in_sign_1 = 0;
        in_sign_2 = 0;
        in_exponent_1 = 8'b01111111;
        in_exponent_2 = 8'b01111111;
        in_mantissa_1 = 24'b1_01000000000000000000000;
        in_mantissa_2 = 24'b1_10000000000000000000000;
        #2
        
        in_sign_1 = 0;
        in_sign_2 = 0;
        in_exponent_1 = 8'b10000100;
        in_exponent_2 = 8'b10000001;
        in_mantissa_1 = 24'b1_01011110000000000000000;
        in_mantissa_2 = 24'b1_01010000000000000000000;
        #2
        
        $finish;
    end
    
    always #1 clk = ~clk;

endmodule
