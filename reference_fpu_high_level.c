#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include "reference_fpu_high_level.h"

int main(void) {

    test_vector vectors[5] = {
        {.operand_a = {.f = 1.0f}, .operand_b = {.f = 1.5f}, .operator = ADD},
        {.operand_a = {.f = 2.0f}, .operand_b = {.f = 2.5f}, .operator = ADD},
        {.operand_a = {.f = 3.0f}, .operand_b = {.f = 3.5f}, .operator = ADD},
        {.operand_a = {.f = 4.0f}, .operand_b = {.f = 4.5f}, .operator = ADD},
        {.operand_a = {.f = 5.0f}, .operand_b = {.f = 5.5f}, .operator = ADD}
    };

    for (uint32_t i = 0; i < 5; i++) {
        vectors[i].result.f = compute(vectors[i].operand_a.f, vectors[i].operand_b.f, vectors[i].operator);
        printResult(vectors[i].operand_a, vectors[i].operand_b, vectors[i].operator, vectors[i].result, i + 1);
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

void printResult(IEEE754_Single_Precision operand_a, IEEE754_Single_Precision operand_b, uint32_t operator, IEEE754_Single_Precision result, uint32_t test_number) {
    printf("Test Case %u:\n    ", test_number);
    printf("%f + %f = %f\n", operand_a.f, operand_b.f, result.f);
}
