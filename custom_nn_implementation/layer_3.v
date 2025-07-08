`timescale 1ns / 1ps

module layer_3 #(
  parameter NUM_INPUTS      = 10,
  parameter DATAWIDTH       = 16,
  parameter WEIGHTINTWIDTH  = 4
)(
  input                        clk,
  input                        rst,
  input                        input_valid,
  input  [DATAWIDTH-1:0]       input_val,
  output [DATAWIDTH*10-1:0]   x_out,
  output [9:0]             o_valid
);

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b0000010100011000),
    .WEIGHTFILE      ("w_3_0.mif")
  ) n_0 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[0*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[0])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b1111011110110110),
    .WEIGHTFILE      ("w_3_1.mif")
  ) n_1 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[1*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[1])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b0000100001111001),
    .WEIGHTFILE      ("w_3_2.mif")
  ) n_2 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[2*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[2])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b1111110100011000),
    .WEIGHTFILE      ("w_3_3.mif")
  ) n_3 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[3*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[3])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b0000100011110100),
    .WEIGHTFILE      ("w_3_4.mif")
  ) n_4 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[4*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[4])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b1111000010010111),
    .WEIGHTFILE      ("w_3_5.mif")
  ) n_5 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[5*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[5])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b0000010111100011),
    .WEIGHTFILE      ("w_3_6.mif")
  ) n_6 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[6*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[6])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b0000101000100101),
    .WEIGHTFILE      ("w_3_7.mif")
  ) n_7 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[7*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[7])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b1111101001111011),
    .WEIGHTFILE      ("w_3_8.mif")
  ) n_8 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[8*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[8])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b1111001111011111),
    .WEIGHTFILE      ("w_3_9.mif")
  ) n_9 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[9*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[9])
  );

endmodule
