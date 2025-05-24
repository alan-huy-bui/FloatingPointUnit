# Floating-Point Unit Design and Verification

## Project Goals
- Design a 5-stage pipelined, single-precision FPU with add, subtract, and multiply operations
- Implement IEEE 754-style round to nearest, ties to even (RNE) rounding, exception handling with flags, and special value handling
- Develop Python scripts with cocotb to automate constrained-random stimulus generation and simulation in Icarus Verilog with GTKWave
- Establish functional coverage goals, with scoreboarding against Berkeley SoftFloat, an IEEE 754-compliant FPU in C
- Optimized pipeline with static timing analysis in Vivado, improving throughput by reducing critical path delays
