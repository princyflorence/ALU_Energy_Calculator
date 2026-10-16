#==============================================================================
# Example SDC Constraints for alu_energy_calculator
# Target frequency: 100 MHz (10 ns period)
#==============================================================================

# Create clock
create_clock -name clk -period 10.0 [get_ports clk]

# Input delays (relative to clock)
set_input_delay  -clock clk -max 2.0 [get_ports {A[*] B[*] ALU_SEL[*] TIME[*] start}]
set_input_delay  -clock clk -min 0.5 [get_ports {A[*] B[*] ALU_SEL[*] TIME[*] start}]

# Output delays
set_output_delay -clock clk -max 2.0 [get_ports {ALU_Result[*] Power_Value[*] Energy_Value[*] Status_Flag done}]
set_output_delay -clock clk -min 0.5 [get_ports {ALU_Result[*] Power_Value[*] Energy_Value[*] Status_Flag done}]

# Reset is asynchronous
set_false_path -from [get_ports rst_n]

# Clock uncertainty
set_clock_uncertainty 0.2 [get_clocks clk]

# Load capacitance (example)
set_load 0.05 [all_outputs]
