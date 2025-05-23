#include <stdint.h>
#include <stdio.h>

#ifndef REFERENCE_FPU_HIGH_LEVEL_H
#define REFERENCE_FPU_HIGH_LEVEL_H

//  Positive and Negative
#define POSITIVE 0
#define NEGATIVE 1

//  Operations
#define ADD 0
#define SUB 1
#define MUL 2

//  Exceptions
#define INV 0
#define OF  1
#define UF  2
#define NX  3

typedef union {
    uint32_t u;
    float f;
} IEEE754_Single_Precision;

typedef struct {
    IEEE754_Single_Precision operand_a;
    IEEE754_Single_Precision operand_b;
    uint32_t operator;
    IEEE754_Single_Precision result;
} test_vector;

float compute(float operand_a, float operand_b, uint32_t operator);
void printResult(IEEE754_Single_Precision operand_a, IEEE754_Single_Precision operand_b, uint32_t operator, IEEE754_Single_Precision result, uint32_t test_number);

#endif
