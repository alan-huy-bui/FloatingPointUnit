#include <stdint.h>
#include <stdio.h>

#ifndef REFERENCE_FPU_WRAPPER_H
#define REFERENCE_FPU_WRAPPER_H

uint32_t reference_fpu_compute(uint32_t operand_a, uint32_t operand_b, uint32_t operator);

enum Operation {
    ADD = 0,
    SUB = 1,
    MUL = 2
};

enum Exceptions {
    INV = 0,
    OF = 1,
    UF = 2,
    NX = 3
};

#endif