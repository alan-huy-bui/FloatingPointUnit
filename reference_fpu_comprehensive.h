#include <stdint.h>
#include <stdio.h>

#ifndef REFERENCE_FPU_COMPREHENSIVE_H
#define REFERENCE_FPU_COMPREHENSIVE_H

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

//  Function Declarations
uint32_t reference(uint32_t operand_a, uint32_t operand_b, uint32_t operator);
void unpack(uint32_t operand_a, uint32_t operand_b, uint32_t operator);
void align(void);
void compute(void);
void normalize(void);
void pack(void);
void printBinary(uint32_t integer_num);
void callReference(float operand_a, float operand_b, uint32_t operator);

#endif