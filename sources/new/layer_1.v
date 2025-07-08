`timescale 1ns / 1ps

module layer_1 #(
  parameter NUM_INPUTS      = 30,
  parameter DATAWIDTH       = 16,
  parameter WEIGHTINTWIDTH  = 4
)(
  input                        clk,
  input                        rst,
  input                        input_valid,
  input  [DATAWIDTH-1:0]       input_val,
  output [DATAWIDTH*30-1:0]    x_out,
  output [29:0]                o_valid
);

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b1111011101100101),
    .WEIGHTFILE      ("w_1_0.mif")
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
    .BIAS            (16'b0000010000001011),
    .WEIGHTFILE      ("w_1_1.mif")
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
    .BIAS            (16'b0000000101111000),
    .WEIGHTFILE      ("w_1_2.mif")
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
    .BIAS            (16'b0000000001100101),
    .WEIGHTFILE      ("w_1_3.mif")
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
    .BIAS            (16'b1111000001111010),
    .WEIGHTFILE      ("w_1_4.mif")
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
    .BIAS            (16'b1111110001110101),
    .WEIGHTFILE      ("w_1_5.mif")
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
    .BIAS            (16'b1111110100111101),
    .WEIGHTFILE      ("w_1_6.mif")
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
    .BIAS            (16'b0000010010001011),
    .WEIGHTFILE      ("w_1_7.mif")
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
    .BIAS            (16'b0000001011000100),
    .WEIGHTFILE      ("w_1_8.mif")
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
    .BIAS            (16'b1111110110100100),
    .WEIGHTFILE      ("w_1_9.mif")
  ) n_9 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[9*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[9])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b1111011001000101),
    .WEIGHTFILE      ("w_1_10.mif")
  ) n_10 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[10*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[10])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b0000000000010111),
    .WEIGHTFILE      ("w_1_11.mif")
  ) n_11 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[11*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[11])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b0000100010011001),
    .WEIGHTFILE      ("w_1_12.mif")
  ) n_12 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[12*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[12])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b1111100100111011),
    .WEIGHTFILE      ("w_1_13.mif")
  ) n_13 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[13*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[13])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b0000010010101010),
    .WEIGHTFILE      ("w_1_14.mif")
  ) n_14 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[14*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[14])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b0000101010011011),
    .WEIGHTFILE      ("w_1_15.mif")
  ) n_15 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[15*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[15])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b0000001000011010),
    .WEIGHTFILE      ("w_1_16.mif")
  ) n_16 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[16*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[16])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b0000001000010101),
    .WEIGHTFILE      ("w_1_17.mif")
  ) n_17 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[17*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[17])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b0000000001110110),
    .WEIGHTFILE      ("w_1_18.mif")
  ) n_18 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[18*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[18])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b0000001010110110),
    .WEIGHTFILE      ("w_1_19.mif")
  ) n_19 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[19*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[19])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b0000001011000000),
    .WEIGHTFILE      ("w_1_20.mif")
  ) n_20 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[20*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[20])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b0000000100111001),
    .WEIGHTFILE      ("w_1_21.mif")
  ) n_21 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[21*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[21])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b1111100111010000),
    .WEIGHTFILE      ("w_1_22.mif")
  ) n_22 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[22*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[22])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b0000001000100011),
    .WEIGHTFILE      ("w_1_23.mif")
  ) n_23 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[23*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[23])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b1111110001010010),
    .WEIGHTFILE      ("w_1_24.mif")
  ) n_24 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[24*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[24])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b1111111100100100),
    .WEIGHTFILE      ("w_1_25.mif")
  ) n_25 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[25*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[25])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b1111101101000100),
    .WEIGHTFILE      ("w_1_26.mif")
  ) n_26 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[26*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[26])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b1111110111001001),
    .WEIGHTFILE      ("w_1_27.mif")
  ) n_27 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[27*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[27])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b0000010101000000),
    .WEIGHTFILE      ("w_1_28.mif")
  ) n_28 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[28*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[28])
  );

  neuron #(
    .NUM_INPUTS      (NUM_INPUTS),
    .DATAWIDTH       (DATAWIDTH),
    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),
    .BIAS            (16'b1111110000011000),
    .WEIGHTFILE      ("w_1_29.mif")
  ) n_29 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[29*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[29])
  );

endmodule
