`timescale 1ns / 1ps

module tb_fpu_compute;
    
    reg clk;
    reg in_sign_1, in_sign_2;
    reg [7:0] in_exponent;
    reg [23:0] in_mantissa_1, in_mantissa_2;
    reg [1:0] in_operator;
    
    wire sign;
    wire [7:0] exponent;
    wire [47:0] mantissa;
    wire [1:0] operator;
    
    fpu_compute DUT (.clk(clk),
                     .in_sign_1(in_sign_1),
                     .in_sign_2(in_sign_2),
                     .in_exponent(in_exponent),
                     .in_mantissa_1(in_mantissa_1),
                     .in_mantissa_2(in_mantissa_2),
                     .in_operator(in_operator),
                     .sign(sign),
                     .exponent(exponent),
                     .mantissa(mantissa),
                     .operator(operator));
                     
    initial begin
        clk = 0;
        in_operator = 2'b00;
        
        in_sign_1 = 0;
        in_sign_2 = 0;
        in_exponent = 8'b00000000;
        in_mantissa_1 = 24'b1_00000000000000000000000;
        in_mantissa_2 = 24'b1_00000000000000000000000;
        #2
        
        in_sign_1 = 0;
        in_sign_2 = 0;
        in_exponent = 8'b01111111;
        in_mantissa_1 = 24'b1_01000000000000000000000;
        in_mantissa_2 = 24'b1_10000000000000000000000;
        #2
        
        in_sign_1 = 0;
        in_sign_2 = 0;
        in_exponent = 8'b10000100;
        in_mantissa_1 = 24'b1_01011110000000000000000;
        in_mantissa_2 = 24'b0_00101010000000000000000;
        #2
        
        $finish;
    end
    
    always #1 clk = ~clk;

endmodule
