# Design and Verification of a 4-Bit ALU-Based Smart Energy Consumption Calculator Using Verilog HDL

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Verilog](https://img.shields.io/badge/Language-Verilog%20HDL-blue.svg)](https://en.wikipedia.org/wiki/Verilog)
[![VLSI](https://img.shields.io/badge/Domain-VLSI%20%7C%20Digital%20Design-green.svg)]()
[![Flow](https://img.shields.io/badge/Flow-RTL%20to%20GDSII-orange.svg)]()

**Author:** princyflorence  
**GitHub:** https://github.com/princyflorence

---

## Abstract

This project presents the design and verification of a **4-Bit ALU-Based Smart Energy Consumption Calculator** using Verilog HDL. The system combines arithmetic and logical operations with energy consumption estimation capabilities in a single digital hardware module. The 4-bit Arithmetic Logic Unit (ALU) performs fundamental operations such as addition, subtraction, multiplication, logical AND, OR, XOR, and comparison. Based on the selected operation and input values, the energy calculation module estimates the energy consumed during processing.

The design is modeled at the Register Transfer Level (RTL) using Verilog HDL and verified through comprehensive simulation and testbench validation. The project follows a standard VLSI design methodology, including RTL design, functional verification, synthesis, static timing analysis (STA), and preparation for physical design implementation. The objective is to demonstrate efficient digital system design while integrating basic energy-awareness concepts commonly used in modern low-power electronic systems.

---

## Features

- 4-bit ALU supporting 8 operations (ADD, SUB, AND, OR, XOR, MUL, ENERGY, CMP)
- Power estimation: `Power = A × B`
- Energy calculation: `Energy = Power × TIME`
- Fully synthesizable RTL
- Multi-corner STA (TT / SS / FF)
- Complete sign-off checklist
- Ready for physical design (OpenROAD / commercial tools)

---

## Operation Encoding

| ALU_SEL | Operation          |
|---------|--------------------|
| 000     | Addition           |
| 001     | Subtraction        |
| 010     | AND                |
| 011     | OR                 |
| 100     | XOR                |
| 101     | Multiplication     |
| 110     | Energy Calculation |
| 111     | Comparison         |

---

## Project Structure (VLSI Flow)

```
ALU_Energy_Calculator/
├── README.md
├── LICENSE
├── .gitignore
├── signoff_checklist.md          ← Final sign-off checklist
├── run_all.sh                    ← Master flow script
├── run_lvs.sh                    ← LVS script
│
├── rtl/                          ← RTL Design
│   └── alu_energy_calculator.v
│
├── tb/                           ← Testbench
│   └── tb_alu_energy_calculator.v
│
├── sim/                          ← Simulation outputs (VCD)
│
├── synthesis/                    ← Yosys Synthesis
│   ├── synthesis_report.txt
│   ├── alu_energy_synth.v
│   └── alu_energy_mapped.v
│
├── sta/                          ← Static Timing Analysis
│   ├── tt_timing.txt             (Typical-Typical)
│   ├── ss_timing.txt             (Slow-Slow)
│   ├── ff_timing.txt             (Fast-Fast)
│   ├── multi_corner_summary.txt
│   └── timing_report.txt
│
├── physical/                     ← Physical Design
│   ├── placement_run/
│   ├── global_route/
│   ├── detailed_route/
│   ├── antenna_check.rpt
│   ├── detailed_route_drc.rpt
│   ├── final_setup_timing.rpt
│   └── final_hold_timing.rpt
│
├── constraints/                  ← SDC Constraints
│   └── timing.sdc
│
├── waveforms/                    ← Waveform captures
├── docs/                         ← Design documentation
│   └── DESIGN_NOTES.md
├── scripts/                      ← Automation scripts
│   ├── run_sim.sh
│   └── synth.ys
└── submission/                   ← Final submission notes
    └── README.txt
```

---

## VLSI Design Flow Covered

```
Specification
     ↓
RTL Design (Verilog HDL)          ✅  rtl/
     ↓
Testbench Development             ✅  tb/
     ↓
Functional Verification           ✅  sim/ + scripts/run_sim.sh
     ↓
Synthesis (Yosys)                 ✅  synthesis/
     ↓
Static Timing Analysis            ✅  sta/ (TT / SS / FF)
     ↓
Floorplanning                     ✅  physical/
     ↓
Placement                         ✅  physical/placement_run/
     ↓
CTS                               ✅  physical/
     ↓
Routing                           ✅  physical/ + detailed_route_drc.rpt
     ↓
DRC                               ✅  physical/detailed_route_drc.rpt
     ↓
LVS                               ✅  run_lvs.sh
     ↓
Signoff                           ✅  signoff_checklist.md
     ↓
GDSII Generation                  ✅  Documented
```

---

## How to Run

### 1. Functional Simulation
```bash
chmod +x scripts/run_sim.sh
./scripts/run_sim.sh
```

### 2. Full Flow (Simulation + Reports)
```bash
chmod +x run_all.sh
./run_all.sh
```

### 3. View Sign-off Checklist
```bash
cat signoff_checklist.md
```

---

## Example Results

| Test   | A  | B  | TIME | Operation | ALU_Result | Power | Energy |
|--------|----|----|------|-----------|------------|-------|--------|
| ADD    | 4  | 3  | 2    | ADD       | 7          | 12    | 24     |
| SUB    | 9  | 5  | 3    | SUB       | 4          | 45    | 135    |
| MUL    | 5  | 6  | 2    | MUL       | 30         | 30    | 60     |
| ENERGY | 7  | 4  | 3    | ENERGY    | 11         | 28    | 84     |
| MAX    | 15 | 15 | 15   | MUL       | 225        | 225   | 3375   |

---

## Timing Summary (Post-Synthesis)

| Corner     | WNS (ns) | TNS (ns) | Status |
|------------|----------|----------|--------|
| TT (25°C)  | +4.12    | 0.00     | PASS   |
| SS (125°C) | +2.87    | 0.00     | PASS   |
| FF (-40°C) | +5.01    | 0.00     | PASS   |

---

## License

MIT License © 2026 princyflorence

---

*This repository follows a complete academic VLSI design flow from RTL to Sign-off.*
