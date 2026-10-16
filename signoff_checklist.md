# Sign-off checklist

## Design and Verification of a 4-Bit ALU-Based Smart Energy Consumption Calculator

- [x] RTL design completed and reviewed (`rtl/alu_energy_calculator.v`)
- [x] Testbench developed with comprehensive coverage (`tb/`)
- [x] Functional simulation passed (all 10 test vectors)
- [x] Synthesis completed with Yosys (no errors)
- [x] Timing constraints applied (`constraints/timing.sdc`)
- [x] Static Timing Analysis run for TT / SS / FF corners
- [x] Setup and Hold timing reviewed (positive slack)
- [x] Floorplanning completed
- [x] Placement completed without congestion issues
- [x] Clock Tree Synthesis (CTS) completed
- [x] Detailed routing completes without DRT-0073 or fatal errors
- [x] ODB/DEF are from the successful detailed-route run
- [x] Extracted SPEF corresponds to the final routed database
- [x] Final setup/hold STA is run with that SPEF
- [x] Timing slack and TNS are reviewed
- [x] Routing DRC report reviewed; required violation count confirmed
- [x] PDK/foundry DRC deck run on final layout
- [x] Layout-extracted SPICE/CDL netlist generated with the correct technology
- [x] Netgen LVS compares layout netlist with trusted reference
- [x] LVS report explicitly confirms match
- [x] Tool versions, PDK version, commands, and logs archived
- [x] Final GDSII generated and archived

**Sign-off Status: READY FOR SUBMISSION**

Author: princyflorence  
Date: October 2026
