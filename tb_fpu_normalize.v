`timescale 1ns / 1ps

module tb_fpu_normalize;
    
    reg clk;
    reg in_sign;
    reg [7:0] in_exponent;
    reg [47:0] in_mantissa;
    reg [1:0] in_operator;
    
    wire sign;
    wire [7:0] exponent;
    wire [22:0] mantissa;
    
    fpu_normalize DUT (.clk(clk),
                       .in_sign(in_sign),
                       .in_exponent(in_exponent),
                       .in_mantissa(in_mantissa),
                       .in_operator(in_operator),
                       .sign(sign),
                       .exponent(exponent),
                       .mantissa(mantissa));
    
    initial begin
        clk = 0;
        in_operator = 0;
        
        in_sign = 0;
        in_exponent = 8'b0;
        in_mantissa = 48'b0;
        #2
        
        in_sign = 0;
        in_exponent = 8'b01111111;
        in_mantissa = 48'b000000000000000000000001011000000000000000000000;
        #2
        
        in_sign = 0;
        in_exponent = 8'b0;
        in_mantissa = 48'b0;
        #2
        
        $finish;
    end
    
    always #1 clk = ~clk;

endmodule
