`timescale 1ns / 1ps

module tb_layer_1;

  parameter NUM_INPUTS     = 30;
  parameter DATAWIDTH      = 16;
  parameter WEIGHTINTWIDTH = 4;

  reg                         clk;
  reg                         rst;
  reg                         input_valid;
  reg  [DATAWIDTH-1:0]        input_val;
  wire [DATAWIDTH*30-1:0]     x_out;
  wire [29:0]                 o_valid;

  layer_1 #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH)
  ) dut (
    .clk             (clk),
    .rst             (rst),
    .input_valid     (input_valid),
    .input_val       (input_val),
    .x_out           (x_out),
    .o_valid         (o_valid)
  );

  always #5 clk = ~clk;

  integer i;

  initial begin
    clk         = 0;
    rst         = 1;
    input_valid = 0;
    input_val   = 0;
    #20 rst = 0;

    for (i = 0; i < NUM_INPUTS; i = i + 1) begin
      @(posedge clk);
      input_valid = 1;
      input_val   = i;
    end

    @(posedge clk);
    input_valid = 0;

    repeat (20) @(posedge clk);
    $finish;
  end

endmodule
