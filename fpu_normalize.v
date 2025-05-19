`timescale 1ns / 1ps

module fpu_normalize(
    input clk,
    input in_sign,
    input [7:0] in_exponent,
    input [47:0] in_mantissa,
    input [1:0] in_operator,
    output reg sign,
    output reg [7:0] exponent,
    output reg [22:0] mantissa
    );
    
    reg [47:0] temp_mantissa;
    reg [22:0] output_mantissa;
    reg [7:0] modified_exponent;
    reg [4:0] shift_amount;
    
    always @ (*) begin
        case (in_operator)
            2'b00, 2'b01 : begin
                if (in_mantissa == 0) begin
                    output_mantissa = 0;
                    modified_exponent = 0;
                end else if (in_mantissa[24]) begin
                    temp_mantissa = in_mantissa >> 1;
                    output_mantissa = temp_mantissa [22:0];
                    modified_exponent = in_exponent + 1'b1;
                end else begin
                    casez (in_mantissa[23:0])
                        24'b1??????????????????????? : shift_amount = 0;
                        24'b01?????????????????????? : shift_amount = 1;
                        24'b001????????????????????? : shift_amount = 2;
                        24'b0001???????????????????? : shift_amount = 3;
                        24'b00001??????????????????? : shift_amount = 4;
                        24'b000001?????????????????? : shift_amount = 5;
                        24'b0000001????????????????? : shift_amount = 6;
                        24'b00000001???????????????? : shift_amount = 7;
                        24'b000000001??????????????? : shift_amount = 8;
                        24'b0000000001?????????????? : shift_amount = 9;
                        24'b00000000001????????????? : shift_amount = 10;
                        24'b000000000001???????????? : shift_amount = 11;
                        24'b0000000000001??????????? : shift_amount = 12;
                        24'b00000000000001?????????? : shift_amount = 13;
                        24'b000000000000001????????? : shift_amount = 14;
                        24'b0000000000000001???????? : shift_amount = 15;
                        24'b00000000000000001??????? : shift_amount = 16;
                        24'b000000000000000001?????? : shift_amount = 17;
                        24'b0000000000000000001????? : shift_amount = 18;
                        24'b00000000000000000001???? : shift_amount = 19;
                        24'b000000000000000000001??? : shift_amount = 20;
                        24'b0000000000000000000001?? : shift_amount = 21;
                        24'b00000000000000000000001? : shift_amount = 22;
                        24'b000000000000000000000001 : shift_amount = 23;
                        default: shift_amount = 0;
                    endcase
                    
                    temp_mantissa = in_mantissa << shift_amount;
                    output_mantissa = temp_mantissa[22:0];
                    modified_exponent = in_exponent - shift_amount;
                end
            end
            
            2'b10 : begin
                if (in_mantissa[47]) begin
                    output_mantissa = in_mantissa[47:24];
                    modified_exponent = in_exponent + 1;
                end else begin
                    output_mantissa = in_mantissa[46:23];
                    modified_exponent = in_exponent;
                end
            end
            
            default: begin
                modified_exponent = 0;
                output_mantissa = 0;
            end
            
        endcase
    end
    
    always @ (posedge clk) begin
        sign <= in_sign;
        exponent <= modified_exponent;
        mantissa <= output_mantissa;
    end
    
endmodule
