`timescale 1ns / 1ps

module tb_top_mnist();

  parameter DATAWIDTH = 16;
  parameter MAX_TEST_SAMPLES = 100;

  reg                     clk;
  reg                     rst;
  reg [DATAWIDTH-1:0]     input_val;
  reg                     input_valid;
  wire [31:0]             out;
  wire                    out_valid;

  reg [DATAWIDTH-1:0] test_data [0:784];  // 0-783: inputs, 784: expected
  string filename;
  integer i, correct = 0, total = 0;

  // Instantiate the top module
  top_mnist #(
    .DATAWIDTH(DATAWIDTH),
    .WEIGHTINTWIDTH(4)  // Set to match the design
  ) uut (
    .clk         (clk),
    .rst         (rst),
    .input_valid (input_valid),
    .input_val   (input_val),
    .out         (out),
    .out_valid   (out_valid)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Task to send a test sample
  task send_sample(input int index);
    begin
      // Format filename with index
      filename = $sformatf("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/test_data_%04d.txt", index);
      
      // Read test data
      $readmemb(filename, test_data);
      
      // Apply inputs
      @(posedge clk);
      input_valid = 1;
      for (i = 0; i < 784; i = i + 1) begin
        input_val = test_data[i];
        @(posedge clk);
      end
      input_valid = 0;
    end
  endtask

  initial begin
    // Initialize
    clk = 0;
    rst = 1;
    input_valid = 0;
    input_val = 0;
    
    // Reset
    #100;
    rst = 0;
    #100;
    
    $display("Starting MNIST classification test...");
    
    // Process test samples
    for (integer sample_idx = 0; sample_idx < MAX_TEST_SAMPLES; sample_idx = sample_idx + 1) begin
      // Send sample
      send_sample(sample_idx);
      
      // Wait for result
      wait(out_valid);
      @(posedge clk);
      
      // Verify result
      total = total + 1;
      if (out == test_data[784]) 
        correct = correct + 1;
      
      // Display progress
      $display("Test %0d - Detected: %0d, Expected: %0d, Accuracy: %0.2f%%", sample_idx, out, test_data[784], (correct * 100.0) / total);
    end
    
    // Final report
    $display("\nTest completed. Final accuracy: %0.2f%% (%0d/%0d)", (correct * 100.0) / total, correct, total);
    $finish;
  end

  // Monitor results
  always @(posedge clk) begin
    if (out_valid) begin
      $display("[%t] Output detected: %0d", $time, out);
    end
  end

  // Waveform dumping
  initial begin
    $dumpfile("tb_top_mnist.vcd");
    $dumpvars(0, tb_top_mnist);
  end

endmodule