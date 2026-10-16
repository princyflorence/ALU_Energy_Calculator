//==============================================================================
// Module      : alu_energy_calculator
// Description : 4-Bit ALU-Based Smart Energy Consumption Calculator
//               Performs arithmetic/logical operations and estimates energy
//               consumption based on operands and processing time.
// Author      : princyflorence
// Date        : 2026
// Language    : Verilog HDL (RTL)
//==============================================================================

`timescale 1ns / 1ps

module alu_energy_calculator (
    input  wire        clk,           // Clock
    input  wire        rst_n,         // Active-low asynchronous reset
    input  wire [3:0]  A,             // First 4-bit operand
    input  wire [3:0]  B,             // Second 4-bit operand
    input  wire [2:0]  ALU_SEL,       // Operation select
    input  wire [3:0]  TIME,          // Processing time (units)
    input  wire        start,         // Start pulse (optional handshake)

    output reg  [7:0]  ALU_Result,    // ALU result (up to 8 bits for MUL)
    output reg  [7:0]  Power_Value,   // Estimated power = A * B
    output reg  [11:0] Energy_Value,  // Energy = Power * TIME
    output reg         Status_Flag,   // 1 = valid result / comparison true
    output reg         done           // Operation complete flag
);

    //--------------------------------------------------------------------------
    // ALU_SEL Encoding
    // 000 : Addition
    // 001 : Subtraction
    // 010 : AND
    // 011 : OR
    // 100 : XOR
    // 101 : Multiplication
    // 110 : Energy Calculation (explicit)
    // 111 : Comparison (A > B)
    //--------------------------------------------------------------------------

    // Internal signals
    reg [7:0]  alu_out;
    reg [7:0]  power_calc;
    reg [11:0] energy_calc;
    reg        status;

    // Combinational ALU + Power + Energy logic
    always @(*) begin
        // Default values
        alu_out     = 8'd0;
        power_calc  = 8'd0;
        energy_calc = 12'd0;
        status      = 1'b0;

        // Power estimation (always computed from operands)
        power_calc = A * B;   // 4-bit * 4-bit = max 8-bit

        case (ALU_SEL)
            3'b000: begin  // Addition
                alu_out = {4'b0, A} + {4'b0, B};
                status  = 1'b1;
            end

            3'b001: begin  // Subtraction (A - B)
                alu_out = {4'b0, A} - {4'b0, B};
                status  = 1'b1;
            end

            3'b010: begin  // Logical AND
                alu_out = {4'b0, (A & B)};
                status  = 1'b1;
            end

            3'b011: begin  // Logical OR
                alu_out = {4'b0, (A | B)};
                status  = 1'b1;
            end

            3'b100: begin  // Logical XOR
                alu_out = {4'b0, (A ^ B)};
                status  = 1'b1;
            end

            3'b101: begin  // Multiplication
                alu_out = A * B;
                status  = 1'b1;
            end

            3'b110: begin  // Explicit Energy Calculation mode
                alu_out     = {4'b0, A} + {4'b0, B};  // still show sum
                energy_calc = power_calc * TIME;
                status      = 1'b1;
            end

            3'b111: begin  // Comparison (A > B)
                alu_out = (A > B) ? 8'd1 : 8'd0;
                status  = (A > B);
            end

            default: begin
                alu_out = 8'd0;
                status  = 1'b0;
            end
        endcase

        // Always compute energy when TIME is provided
        energy_calc = power_calc * TIME;
    end

    // Sequential output registers (synchronous)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ALU_Result   <= 8'd0;
            Power_Value  <= 8'd0;
            Energy_Value <= 12'd0;
            Status_Flag  <= 1'b0;
            done         <= 1'b0;
        end
        else begin
            if (start) begin
                ALU_Result   <= alu_out;
                Power_Value  <= power_calc;
                Energy_Value <= energy_calc;
                Status_Flag  <= status;
                done         <= 1'b1;
            end
            else begin
                done <= 1'b0;
            end
        end
    end

endmodule
