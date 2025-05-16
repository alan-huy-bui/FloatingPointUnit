`timescale 1ns / 1ps

module tb_fpu_unpack;
    
    reg clk;
    reg [31:0] operand_a, operand_b;
    reg [1:0] operator;
    wire sign_1, sign_2;
    wire [7:0] exponent_1, exponent_2;
    wire [23:0] mantissa_1, mantissa_2;
    wire [1:0] out_operator;
    
    fpu_unpack DUT (.clk(clk),
                    .in_operand_a(operand_a),
                    .in_operand_b(operand_b),
                    .in_operator(operator),
                    .sign_1(sign_1),
                    .sign_2(sign_2),
                    .exponent_1(exponent_1),
                    .exponent_2(exponent_2),
                    .mantissa_1(mantissa_1),
                    .mantissa_2(mantissa_2),
                    .operator(out_operator));
    
    initial begin
        clk = 0;
        operator = 2'b00;
        
        operand_a = 32'b0_00000000_00000000000000000000000;
        operand_b = 32'b0_00000000_00000000000000000000000;
        #2
        
        operand_a = 32'b0_01111111_01000000000000000000000;
        operand_b = 32'b0_01111111_10000000000000000000000;
        #2
        
        operand_a = 32'b0_10000100_01011110000000000000000;
        operand_b = 32'b0_10000001_01010000000000000000000;
        #2
        
        $finish;
    end
    
    always #1 clk = ~clk;

endmodule
