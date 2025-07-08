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

  reg [DATAWIDTH-1:0] test_data [0:784];
  reg [DATAWIDTH-1:0] expected;
  string filename;
  integer i, correct = 0, incorrect = 0;

  top_mnist uut (
    .clk         (clk),
    .rst         (rst),
    .input_valid (input_valid),
    .input_val   (input_val),
    .out         (out),
    .out_valid   (out_valid)
  );

  initial clk = 0;
  always #5 clk = ~clk;

  task send_sample(input int index);
    begin
      filename = $sformatf("test_data_%04d.txt", index);
      $readmemb(filename, test_data);
      expected = test_data[784];
      @(posedge clk);
      input_valid = 1;
      for (i = 0; i < 784; i++) begin
        input_val = test_data[i];
        @(posedge clk);
      end
      input_valid = 0;
    end
  endtask

  task wait_for_result();
    begin
      wait (out_valid);
      @(posedge clk);
    end
  endtask

  initial begin
    clk = 0;
    rst = 1;
    input_valid = 0;
    input_val = 0;
    repeat(10) @(posedge clk);
    rst = 0;

    for (i = 0; i < MAX_TEST_SAMPLES; i++) begin
      send_sample(i);
      wait_for_result();
      if (out == expected) correct++;
      else incorrect++;
      $display("Test %0d - Detected: %0d, Expected: %0d, Accuracy: %f%%", i, out, expected, correct * 100.0 / (i + 1));
    end

    $display("Final Accuracy: %f%% (%0d/%0d)", correct * 100.0 / MAX_TEST_SAMPLES, correct, MAX_TEST_SAMPLES);
    $finish;
  end

endmodule
