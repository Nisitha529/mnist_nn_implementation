`timescale 1ns / 1ps

module tb_neuron;

  // Parameters matching the new neuron interface
  localparam DATAWIDTH       = 16;
  localparam NUM_INPUTS      = 4;        // Reduced for simulation efficiency
  localparam WEIGHTINTWIDTH  = 4;
  localparam BIAS            = 16'd1;   // Fixed bias value
  localparam WEIGHTFILE      = "test_weights.mif";
  
  // Clock and Reset
  reg                       clk;
  reg                       rst;
  
  // Neuron Interface (simplified)
  reg                       input_valid;
  reg  [DATAWIDTH-1:0]      input_val;
  wire [DATAWIDTH-1:0]      out;
  wire                      out_valid;
  
  // Test variables
  integer i;
  integer f;
  
  reg [DATAWIDTH-1:0] test_inputs [0:NUM_INPUTS-1];
  
  // Instantiate the Neuron
  neuron #(
    .NUM_INPUTS     (NUM_INPUTS),
    .DATAWIDTH      (DATAWIDTH),
    .WEIGHTINTWIDTH (WEIGHTINTWIDTH),
    .BIAS           (BIAS),
    .WEIGHTFILE     (WEIGHTFILE)
  ) uut (
    .clk            (clk),
    .rst            (rst),
    .input_val      (input_val),
    .input_valid    (input_valid),
    .out            (out),
    .out_valid      (out_valid)
  );
  
  // Clock generation
  always #5 clk = ~clk;
  
  // Initialize test vectors
  initial begin
    // Simple test vectors (1, 2, 3, 4)
    test_inputs[0] = 16'd1;
    test_inputs[1] = 16'd2;
    test_inputs[2] = 16'd3;
    test_inputs[3] = 16'd4;
  end
  
  // Create weight file for the test
  initial begin
    f = $fopen(WEIGHTFILE, "w");
    if (f) begin
      for (integer i = 0; i < NUM_INPUTS; i = i + 1) begin
        // Write weight value 1 for all weights (16-bit binary)
        $fwrite(f, "0000000000000001\n"); 
      end
      $fclose(f);
    end else begin
      $display("Error: Could not create weight file!");
      $finish;
    end
  end
  
  // Main test sequence
  initial begin
    // Initialize inputs
    clk         = 0;
    rst         = 1;
    input_val   = 0;
    input_valid = 0;
    
    // Reset the system
    #20;
    rst = 0;
    #20;
    
    // Test 1: Send inputs
    $display("Sending inputs...");
    for (i = 0; i < NUM_INPUTS; i = i + 1) begin
      input_val = test_inputs[i];
      input_valid = 1;
      #10;
    end
    input_valid = 0;
    
    // Wait for output
    wait(out_valid);
    $display("Output valid! Result = %h (Decimal: %0d)", out, $signed(out));
    
    // Verify result
    // Expected calculation:
    // Accumulator = (1*1 + 2*1 + 3*1 + 4*1) + (16 << 16)
    //             = 10 + 1,048,576 = 1,048,586 (0x0010000A)
    // ReLU output: bits [31:16] = 0x0010 = 16
    if (out !== 16) begin
      $display("ERROR: Expected 16 (0x001A), got %0d (0x%h)", $signed(out), out);
    end else begin
      $display("SUCCESS: Correct output received");
    end
    
    // End simulation
    #100 $display("Test completed!");
    $finish;
  end
  
  // Monitor to track important signals
  initial begin
    $timeformat(-9, 2, " ns", 6);
    $monitor("At %t: input_val=%0d, input_valid=%b, out=%0d, out_valid=%b",
             $time, $signed(input_val), input_valid, $signed(out), out_valid);
  end
  
  // Waveform dumping
  initial begin
    $dumpfile("tb_neuron.vcd");
    $dumpvars(0, tb_neuron);
  end
endmodule