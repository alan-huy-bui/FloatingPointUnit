#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include "reference_fpu_high_level.h"

int main(void) {

    IEEE754 operand_a[5] = {
        {.f = 1.0f},
        {.f = 2.0f},
        {.f = 3.0f},
        {.f = 4.0f},
        {.f = 5.0f}
    };

    IEEE754 operand_b[5] = {
        {.f = 5.0f},
        {.f = 4.0f},
        {.f = 3.0f},
        {.f = 2.0f},
        {.f = 1.0f}
    };

    uint32_t operator[5] = {
        ADD,
        ADD,
        ADD,
        ADD,
        ADD
    };

    IEEE754 result[5];

    for (uint32_t i = 0; i < 5; i++) {
        result[i].f = compute(operand_a[i].f, operand_b[i].f, operator[i]);
        printResult(operand_a[i], operand_b[i], operator[i], result[i], i + 1);
    }

    return 0;
}

float compute(float operand_a, float operand_b, uint32_t operator) {
    switch (operator) {
        case ADD:
            return operand_a + operand_b;
        default:
            return 0.0;
    }
}

void printResult(IEEE754 operand_a, IEEE754 operand_b, uint32_t operator, IEEE754 result, uint32_t test_number) {
    printf("Test Case %u:\n    ", test_number);
    printf("%f + %f = %f\n", operand_a.f, operand_b.f, result.f);
}