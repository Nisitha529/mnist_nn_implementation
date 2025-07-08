`timescale 1ns / 1ps

module maxfinder_tb;

  parameter NUM_INPUTS  = 8;
  parameter DATAWIDTH   = 16;

  reg                             clk;
  reg                             rst;
  reg  [NUM_INPUTS*DATAWIDTH-1:0] i_data;
  reg                             i_valid;
  wire [31:0]                     o_data;
  wire                            o_data_valid;

  maxfinder #(
    .numInput     (NUM_INPUTS),
    .inputWidth   (DATAWIDTH)
  ) dut (
    .i_clk        (clk),
    .i_data       (i_data),
    .i_valid      (i_valid),
    .o_data       (o_data),
    .o_data_valid (o_data_valid)
  );

  initial begin
    clk     = 0;
    rst     = 0;
    i_valid = 0;
    i_data  = 0;
    #10;

    // Provide inputs: max value at index 5 (value = 100)
    i_data = {
      16'd10, 16'd25, 16'd33, 16'd8,
      16'd12, 16'd100, 16'd44, 16'd15
    };
    i_valid = 1;
    #10;
    i_valid = 0;

    // Wait for output
    wait (o_data_valid);
    $display("Max index: %0d", o_data);  // Expected: 5
    $finish;
  end

  always #5 clk = ~clk;

endmodule
