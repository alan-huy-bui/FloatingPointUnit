#include <stdio.h>
#include <stdint.h>
#include "softfloat.h"
#include "softfloat_types.h"
#include "reference_fpu.h"


uint32_t reference_fpu(uint32_t in_a, uint32_t in_b, uint32_t operator) {
    float32_t operand_a, operand_b, result;

    operand_a.v = in_a;
    operand_b.v = in_b;

    switch (operator) {
        case ADD:
            result = f32_add(operand_a, operand_b);
            break;
        case SUB:
            result = f32_sub(operand_a, operand_b);
            break;
        case MUL:
            result = f32_mul(operand_a, operand_b);
            break;
        default:
            result.v = 0;
            break;
    };

    return result.v;
}