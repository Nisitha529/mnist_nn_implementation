`timescale 1ns / 1ps

module layer_2 #(
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
    .BIAS            (16'b0000001010011011),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_0.mif")
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
    .BIAS            (16'b1111111011110001),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_1.mif")
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
    .BIAS            (16'b0000000110111100),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_2.mif")
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
    .BIAS            (16'b1111011100011001),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_3.mif")
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
    .BIAS            (16'b1111110000010101),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_4.mif")
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
    .BIAS            (16'b0000001000001010),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_5.mif")
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
    .BIAS            (16'b1111110000000001),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_6.mif")
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
    .BIAS            (16'b1111111111011001),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_7.mif")
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
    .BIAS            (16'b1111011101101001),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_8.mif")
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
    .BIAS            (16'b1111101101110010),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_9.mif")
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
    .BIAS            (16'b0000011111110001),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_10.mif")
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
    .BIAS            (16'b1111111111101100),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_11.mif")
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
    .BIAS            (16'b1111011010011010),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_12.mif")
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
    .BIAS            (16'b1111001010001111),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_13.mif")
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
    .BIAS            (16'b1111110100000110),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_14.mif")
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
    .BIAS            (16'b0000010110011010),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_15.mif")
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
    .BIAS            (16'b0000001101110001),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_16.mif")
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
    .BIAS            (16'b0000010100010000),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_17.mif")
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
    .BIAS            (16'b1111100100100111),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_18.mif")
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
    .BIAS            (16'b1111000100111101),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_19.mif")
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
    .BIAS            (16'b0000010100001110),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_20.mif")
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
    .BIAS            (16'b1111110110010010),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_21.mif")
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
    .BIAS            (16'b1111111110001001),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_22.mif")
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
    .BIAS            (16'b0000010011100000),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_23.mif")
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
    .BIAS            (16'b1111100101000111),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_24.mif")
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
    .BIAS            (16'b0000001010110110),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_25.mif")
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
    .BIAS            (16'b1111100010100110),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_26.mif")
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
    .BIAS            (16'b1111110010011011),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_27.mif")
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
    .BIAS            (16'b0000001001001010),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_28.mif")
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
    .BIAS            (16'b0000010111001011),
    .WEIGHTFILE      ("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_2_29.mif")
  ) n_29 (
    .clk             (clk),
    .rst             (rst),
    .input_val       (input_val),
    .input_valid     (input_valid),
    .out             (x_out[29*DATAWIDTH+:DATAWIDTH]),
    .out_valid       (o_valid[29])
  );

endmodule
