#!/bin/bash
#==============================================================================
# Simulation script for ALU Energy Calculator
# Requires: iverilog, vvp (Icarus Verilog)
# Optional : gtkwave
#==============================================================================

set -e

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC_DIR="$PROJECT_ROOT/src"
TB_DIR="$PROJECT_ROOT/tb"
SIM_DIR="$PROJECT_ROOT/sim"

mkdir -p "$SIM_DIR"

echo "============================================================"
echo " Compiling RTL + Testbench with Icarus Verilog"
echo "============================================================"

iverilog -g2012 \
    -o "$SIM_DIR/alu_energy.vvp" \
    "$SRC_DIR/alu_energy_calculator.v" \
    "$TB_DIR/tb_alu_energy_calculator.v"

echo "Compilation successful."
echo ""
echo "============================================================"
echo " Running simulation..."
echo "============================================================"

cd "$SIM_DIR"
vvp alu_energy.vvp

echo ""
echo "============================================================"
echo " Simulation finished."
echo " VCD file : $SIM_DIR/alu_energy_calculator.vcd"
echo "============================================================"

# Uncomment to auto-open GTKWave
# if command -v gtkwave &> /dev/null; then
#     gtkwave "$SIM_DIR/alu_energy_calculator.vcd" &
# fi
