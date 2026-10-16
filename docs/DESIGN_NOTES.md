# Design Notes – 4-Bit ALU-Based Smart Energy Consumption Calculator

## 1. Design Objectives

- Demonstrate a complete RTL-to-GDSII ready digital design flow.
- Integrate basic energy-awareness concepts into a classic ALU.
- Provide a clean, well-documented educational example.

## 2. Architecture Overview

The design consists of three main functional blocks:

1. **4-bit ALU** – Performs arithmetic and logical operations selected by `ALU_SEL`.
2. **Power Estimator** – Computes an approximate power metric as `Power = A × B`.
3. **Energy Calculator** – Computes `Energy = Power × TIME`.

All outputs are registered on the rising edge of `clk` when `start` is asserted.

## 3. Power / Energy Model (Simplified)

This project uses a **highly simplified educational model**:

```
Power  = A × B          (units arbitrary)
Energy = Power × TIME   (units arbitrary)
```

In a real low-power design one would consider:

- Switching activity (α)
- Capacitance (C)
- Supply voltage (Vdd)
- Clock frequency (f)

  → Dynamic Power ≈ α × C × Vdd² × f

The current model is intentionally simple so that students can focus on the digital design and verification flow rather than complex power modeling.

## 4. Interface Summary

| Signal        | Direction | Width | Description                          |
|---------------|-----------|-------|--------------------------------------|
| clk           | in        | 1     | System clock                         |
| rst_n         | in        | 1     | Active-low asynchronous reset        |
| A             | in        | 4     | Operand A                            |
| B             | in        | 4     | Operand B                            |
| ALU_SEL       | in        | 3     | Operation select                     |
| TIME          | in        | 4     | Processing time units                |
| start         | in        | 1     | Start pulse                          |
| ALU_Result    | out       | 8     | ALU result (supports multiplication)|
| Power_Value   | out       | 8     | Estimated power                       |
| Energy_Value  | out       | 12    | Estimated energy                      |
| Status_Flag   | out       | 1     | Valid / comparison result            |
| done          | out       | 1     | Operation complete                   |

## 5. Reset & Handshake

- Asynchronous active-low reset (`rst_n`).
- `start` is a single-cycle pulse that captures the current inputs and produces outputs on the next clock edge.
- `done` is asserted for one cycle after a successful capture.

## 6. Verification Strategy

The testbench covers:

- All 8 ALU operations
- Typical values (example from abstract: A=4, B=3, TIME=2)
- Corner cases (max values 15×15)
- Comparison true/false paths
- Reset behavior

Waveform dumping (VCD) is enabled for visual debugging with GTKWave.

## 7. Synthesis Considerations

- Fully synthesizable (no behavioral delays, no initial blocks in RTL).
- Multiplication is inferred; for ASIC one may want a dedicated multiplier or booth encoding.
- Registered outputs help meeting timing and avoid combinational loops.

## 8. Possible Extensions

- Make bit-width parameterized (`parameter WIDTH = 4`)
- Add more ALU functions (shift, rotate, absolute difference…)
- Implement a more realistic power model with activity factors
- Add AXI-Lite or simple memory-mapped register interface
- Target open-source PDK (Sky130) with OpenROAD flow
