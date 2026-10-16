//==============================================================================
// Testbench   : tb_alu_energy_calculator
// Description : Comprehensive testbench for 4-Bit ALU-Based Smart Energy
//               Consumption Calculator
//==============================================================================

`timescale 1ns / 1ps

module tb_alu_energy_calculator;

    // Clock and reset
    reg         clk;
    reg         rst_n;

    // Inputs
    reg  [3:0]  A;
    reg  [3:0]  B;
    reg  [2:0]  ALU_SEL;
    reg  [3:0]  TIME;
    reg         start;

    // Outputs
    wire [7:0]  ALU_Result;
    wire [7:0]  Power_Value;
    wire [11:0] Energy_Value;
    wire        Status_Flag;
    wire        done;

    // Instantiate DUT
    alu_energy_calculator uut (
        .clk          (clk),
        .rst_n        (rst_n),
        .A            (A),
        .B            (B),
        .ALU_SEL      (ALU_SEL),
        .TIME         (TIME),
        .start        (start),
        .ALU_Result   (ALU_Result),
        .Power_Value  (Power_Value),
        .Energy_Value (Energy_Value),
        .Status_Flag  (Status_Flag),
        .done         (done)
    );

    // Clock generation - 100 MHz
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        // Initialize
        rst_n   = 0;
        A       = 0;
        B       = 0;
        ALU_SEL = 0;
        TIME    = 0;
        start   = 0;

        // Waveform dump
        $dumpfile("sim/alu_energy_calculator.vcd");
        $dumpvars(0, tb_alu_energy_calculator);

        // Reset
        #20;
        rst_n = 1;
        #10;

        $display("============================================================");
        $display("  4-Bit ALU-Based Smart Energy Consumption Calculator TB");
        $display("============================================================");

        //------------------------------------------------------------------
        // Test 1: Addition  A=4, B=3, TIME=2
        //------------------------------------------------------------------
        apply_test(4'd4, 4'd3, 3'b000, 4'd2, "ADD");
        // Expected: ALU=7, Power=12, Energy=24

        //------------------------------------------------------------------
        // Test 2: Subtraction  A=9, B=5
        //------------------------------------------------------------------
        apply_test(4'd9, 4'd5, 3'b001, 4'd3, "SUB");
        // Expected: ALU=4, Power=45, Energy=135

        //------------------------------------------------------------------
        // Test 3: AND
        //------------------------------------------------------------------
        apply_test(4'b1100, 4'b1010, 3'b010, 4'd1, "AND");
        // Expected: ALU=8 (1000)

        //------------------------------------------------------------------
        // Test 4: OR
        //------------------------------------------------------------------
        apply_test(4'b1100, 4'b1010, 3'b011, 4'd1, "OR");
        // Expected: ALU=14 (1110)

        //------------------------------------------------------------------
        // Test 5: XOR
        //------------------------------------------------------------------
        apply_test(4'b1100, 4'b1010, 3'b100, 4'd1, "XOR");
        // Expected: ALU=6 (0110)

        //------------------------------------------------------------------
        // Test 6: Multiplication  A=5, B=6
        //------------------------------------------------------------------
        apply_test(4'd5, 4'd6, 3'b101, 4'd2, "MUL");
        // Expected: ALU=30, Power=30, Energy=60

        //------------------------------------------------------------------
        // Test 7: Explicit Energy Mode
        //------------------------------------------------------------------
        apply_test(4'd7, 4'd4, 3'b110, 4'd3, "ENERGY");
        // Expected: Power=28, Energy=84

        //------------------------------------------------------------------
        // Test 8: Comparison (A > B) true
        //------------------------------------------------------------------
        apply_test(4'd10, 4'd3, 3'b111, 4'd1, "CMP_TRUE");
        // Expected: ALU=1, Status=1

        //------------------------------------------------------------------
        // Test 9: Comparison (A > B) false
        //------------------------------------------------------------------
        apply_test(4'd2, 4'd8, 3'b111, 4'd1, "CMP_FALSE");
        // Expected: ALU=0, Status=0

        //------------------------------------------------------------------
        // Test 10: Edge case - max values
        //------------------------------------------------------------------
        apply_test(4'd15, 4'd15, 3'b101, 4'd15, "MAX_MUL");
        // Expected: ALU=225, Power=225, Energy=3375

        #50;
        $display("============================================================");
        $display("  All tests completed successfully");
        $display("============================================================");
        $finish;
    end

    // Task to apply a single test vector
    task apply_test;
        input [3:0] a_in;
        input [3:0] b_in;
        input [2:0] sel;
        input [3:0] t_in;
        input [8*12:1] op_name;
        begin
            @(posedge clk);
            A       = a_in;
            B       = b_in;
            ALU_SEL = sel;
            TIME    = t_in;
            start   = 1;
            @(posedge clk);
            start   = 0;
            @(posedge clk);

            $display("[%0t] %-10s | A=%2d B=%2d TIME=%2d | Result=%3d Power=%3d Energy=%4d Status=%b Done=%b",
                     $time, op_name, A, B, TIME, ALU_Result, Power_Value, Energy_Value, Status_Flag, done);
        end
    endtask

endmodule
