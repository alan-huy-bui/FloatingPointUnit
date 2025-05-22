#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include "tb_fpu_reference.h"


static uint32_t sign_1, sign_2;
static uint32_t exponent_1, exponent_2;
static uint32_t mantissa_1, mantissa_2;
static uint32_t operation;

static uint32_t sign_final;
static uint32_t exponent_final;
static uint32_t mantissa_final;

static uint32_t output;

static uint32_t exceptions[4];


int main(void) {
    callReference(2.5f, 7.0f, 0);
    return 0;
}


//  Function To Call
uint32_t reference(uint32_t operand_a, uint32_t operand_b, uint32_t operator) {
    unpack(operand_a, operand_b, operator);
    align();
    // checkInitialExceptions();
    compute();
    normalize();
    pack();

    return output;
}


void unpack(uint32_t operand_a, uint32_t operand_b, uint32_t operator) {
    uint32_t sign_a = operand_a >> 31;
    uint32_t sign_b = operand_b >> 31;

    uint32_t exponent_a = (operand_a >> 23) & 0xFF;
    uint32_t exponent_b = (operand_b >> 23) & 0xFF;

    uint32_t mantissa_a = operand_a & 0x7FFFFF;
    uint32_t mantissa_b = operand_b & 0x7FFFFF;

    operation = operator;

    if (operation == SUB) {
        sign_b = !sign_b;
    }

    bool swapOperators = (exponent_a < exponent_b) || ((exponent_a == exponent_b) && (mantissa_a < mantissa_b));

    if (swapOperators) {
        sign_1 = sign_b;
        sign_2 = sign_a;

        exponent_1 = exponent_b;
        exponent_2 = exponent_a;

        mantissa_1 = (exponent_1 == 0) ? mantissa_b : ((1 << 23) + mantissa_b);
        mantissa_2 = (exponent_2 == 0) ? mantissa_a : ((1 << 23) + mantissa_a);
    } else {
        sign_1 = sign_a;
        sign_2 = sign_b;

        exponent_1 = exponent_a;
        exponent_2 = exponent_b;
        
        mantissa_1 = (exponent_1 == 0) ? mantissa_a : ((1 << 23) + mantissa_a);
        mantissa_2 = (exponent_2 == 0) ? mantissa_b : ((1 << 23) + mantissa_b);
    }
}


void align(void) {
    if (operation == ADD || operation == SUB) {
        mantissa_2 = mantissa_2 >> (exponent_1 - exponent_2);
        exponent_final = exponent_1;
    }
}


void compute(void) {
    if (operation == ADD || operation == SUB) {
        if (sign_1 == POSITIVE && sign_2 == POSITIVE) {
            mantissa_final = mantissa_1 + mantissa_2;
            sign_final = POSITIVE;

        } else if (sign_1 == POSITIVE && sign_2 == NEGATIVE) {
            mantissa_final = mantissa_1 - mantissa_2;
            sign_final = POSITIVE;

        } else if (sign_1 == NEGATIVE && sign_2 == POSITIVE) {
            mantissa_final = mantissa_2 - mantissa_1;
            sign_final = NEGATIVE;

        } else if (sign_1 == NEGATIVE && sign_2 == NEGATIVE) {
            mantissa_final = mantissa_1 + mantissa_2;
            sign_final = NEGATIVE;
        }
    } else if (operation == MUL) {
        mantissa_final = mantissa_1 * mantissa_2;
        sign_final = sign_1 ^ sign_2;
    }
}


void normalize(void) {
    if (operation == ADD || operation == SUB) {
        if (mantissa_final == 0) {
            mantissa_final = 0;
            exponent_final = 0;
        } else if (mantissa_final >> 24) {
            mantissa_final = (mantissa_final >> 1) & 0x7FFFFF;
            exponent_final++;
        } else {
            uint32_t shift_amount = 0;

            for (uint32_t i = 0; i <= 23; i++) {
                if ((mantissa_final & (1 << i)) != 0) {
                    shift_amount = 23 - i;
                }
            }

            mantissa_final = (mantissa_final << shift_amount) & 0x7FFFFF;
            exponent_final -= shift_amount;
        }
    }
}

void pack(void) {
    //  Check for Zero
    /*
    if ((mantissa_final == 0) && (exponent_final != 255)) {
        if (sign_1 && sign_2) {
            sign_final = 1;
        } else {
            sign_final = 0;
        }

        exponent_final = 0;
    }
    */

    output = (sign_final << 31) + (exponent_final << 23) + mantissa_final;
}


/*
void checkInitialExceptions(void) {
    
}
*/


void printBinary(uint32_t integer_num) {
    for (int i = (sizeof(uint32_t) * 8) - 1; i >= 0; i--) {
        printf("%u", (integer_num >> i) & 0x1);
    }
}

union {
    uint32_t u;
    float f;
} ieee754;

void callReference(float operand_a, float operand_b, uint32_t operator) {
    union {uint32_t u; float f;} op_a;
    union {uint32_t u; float f;} op_b;
    op_a.f = operand_a;
    op_b.f = operand_b;

    uint32_t out = reference(op_a.u, op_b.u, operator);

    union {uint32_t u; float f;} outF;
    outF.u = out;

    printf("Test: %f + %f = %f\n", op_a.f, op_b.f, outF.f);
    printf("      "); printBinary(op_a.u); printf(" + "); printBinary(op_b.u); printf(" = "); printBinary(outF.u);
    printf("\n");
}