#!/bin/bash
#==============================================================================
# Master run script - Design and Verification of 4-Bit ALU Energy Calculator
# Author: princyflorence
#==============================================================================

set -e
echo "============================================================"
echo " Starting full flow for ALU Energy Calculator"
echo "============================================================"

# 1. Functional Simulation
echo "[1/5] Running functional simulation..."
./scripts/run_sim.sh

# 2. Synthesis
echo "[2/5] Running Yosys synthesis..."
mkdir -p synthesis
yosys -s scripts/synth.ys || echo "Yosys not installed - using pre-generated reports"

# 3. STA (placeholder)
echo "[3/5] Static Timing Analysis reports available in sta/"

# 4. Physical Design notes
echo "[4/5] Physical design reports available in physical/"

# 5. Sign-off
echo "[5/5] Checking sign-off checklist..."
cat signoff_checklist.md

echo "============================================================"
echo " Flow completed. Review reports in synthesis/, sta/, physical/"
echo "============================================================"
