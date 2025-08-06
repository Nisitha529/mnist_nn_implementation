`timescale 1ns / 1ps

module tb_layer_4();

    // Parameters
    parameter NUM_INPUTS   = 10;
    parameter DATAWIDTH    = 16;
    parameter WEIGHTINTWIDTH = 4;
    parameter CLOCK_PERIOD = 10;  // 100 MHz clock
    parameter NUM_NEURONS  = 10;
  
    // Signals
    reg                                     clk;
    reg                                     rst;
    reg                                     input_valid;
    reg        [DATAWIDTH-1:0]              input_val;
    wire       [DATAWIDTH*10-1:0]           x_out;
    wire       [9:0]                        o_valid;
  
    // Testbench variables
    integer i;
  
    // Instantiate DUT
    layer_4 #(
        .NUM_INPUTS     (NUM_INPUTS),
        .DATAWIDTH      (DATAWIDTH),
        .WEIGHTINTWIDTH (WEIGHTINTWIDTH)
    ) dut (
        .clk            (clk),
        .rst            (rst),
        .input_valid    (input_valid),
        .input_val      (input_val),
        .x_out          (x_out),
        .o_valid        (o_valid)
    );
  
    // Clock generation
    initial begin
        clk = 0;
        forever #(CLOCK_PERIOD/2) clk = ~clk;
    end
  
    // Main test sequence
    initial begin
        // Initialize signals
        rst         = 1;
        input_valid = 0;
        input_val   = 0;
    
        // Reset sequence
        #(CLOCK_PERIOD*5);
        rst = 0;
        #(CLOCK_PERIOD*5);
    
        $display("[%0t] Starting test for layer_4", $time);
    
        // Feed input data
        $display("[%0t] Applying input sequence...", $time);
        input_valid = 1;
        for (i = 0; i < NUM_INPUTS; i = i + 1) begin
            // Input values 1, 2, 3, ... 10
            input_val = i + 1;
            #CLOCK_PERIOD;
            $display("[%0t] Input %2d: %4d (0x%4h)", $time, i, input_val, input_val);
        end
        input_valid = 0;
    
        // Wait for all outputs to be ready
        $display("[%0t] Waiting for outputs...", $time);
        wait (o_valid == 10'b1111111111);
    
        // Display and verify outputs
        $display("\n[%0t] All outputs valid:", $time);
        for (i = 0; i < NUM_NEURONS; i = i + 1) begin
            $display("  Neuron %0d: %4d (0x%4h)", i, $signed(x_out[i*DATAWIDTH +: DATAWIDTH]), x_out[i*DATAWIDTH +: DATAWIDTH]);
        end
    
        $display("\n[%0t] TEST COMPLETED", $time);
        $finish;
    end
  
    // Timeout watchdog
    initial begin
        #(CLOCK_PERIOD * (NUM_INPUTS * 10 + 500));  // Allow extra cycles
        $display("\n[%0t] ERROR: Simulation timed out!", $time);
        $display("Current o_valid: %10b", o_valid);
        $finish;
    end
  
    // Waveform dumping
    initial begin
        $dumpfile("tb_layer_4.vcd");
        $dumpvars(0, tb_layer_4);
    end
endmodule