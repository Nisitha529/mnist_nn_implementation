`timescale 1ns / 1ps

module tb_neuron;

  localparam DATAWIDTH       = 16;
  localparam NUM_INPUTS      = 4;
  localparam WEIGHTINTWIDTH  = 4;
  localparam BIAS            = 16'd16;
  localparam ADDR_WIDTH      = $clog2(NUM_INPUTS);
  localparam WEIGHTFILE      = "test_weights.mif";

  reg                        clk;
  reg                        rst;
  reg                        input_valid;
  reg  [DATAWIDTH-1:0]       input_val;
  wire [DATAWIDTH-1:0]       out;
  wire                       out_valid;

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (BIAS),
    .WEIGHTFILE      (WEIGHTFILE)
  ) dut (
    .clk          (clk),
    .rst          (rst),
    .input_val    (input_val),
    .input_valid  (input_valid),
    .out          (out),
    .out_valid    (out_valid)
  );

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    rst = 1;
    input_val = 0;
    input_valid = 0;
    #20;
    rst = 0;

    // Apply NUM_INPUTS input values
    repeat (NUM_INPUTS) begin
      @(posedge clk);
      input_val   <= $random % 20;  
      input_valid <= 1;
    end

    @(posedge clk);
    input_valid <= 0;

    // Wait for neuron output
    wait(out_valid);
    @(posedge clk);
    $display("NEURON OUTPUT: %0d", $signed(out));

    #20 $finish;
  end

  initial begin
    $display("Time\t input_val\t out\t out_valid");
    $monitor("%t\t %0d\t\t %0d\t %b", $time, $signed(input_val), $signed(out), out_valid);
  end

endmodule
