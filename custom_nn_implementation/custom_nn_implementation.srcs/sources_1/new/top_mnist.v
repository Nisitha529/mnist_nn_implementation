`timescale 1ns / 1ps

module top_mnist #(
  parameter DATAWIDTH       = 16,
  parameter L1_NUM_NEURONS = 30,
  parameter L1_NUM_INPUTS  = 784,
  parameter L2_NUM_NEURONS = 30,
  parameter L2_NUM_INPUTS  = 30,
  parameter L3_NUM_NEURONS = 10,
  parameter L3_NUM_INPUTS  = 30,
  parameter L4_NUM_NEURONS = 10,
  parameter L4_NUM_INPUTS  = 10,
  parameter WEIGHTINTWIDTH = 4
)(
  input                        clk,
  input                        rst,
  input                        input_valid,
  input  [DATAWIDTH-1:0]       input_val,
  output [31:0]                out,
  output                       out_valid
);

  wire [L1_NUM_NEURONS-1:0]           o1_valid;
  wire [DATAWIDTH*L1_NUM_NEURONS-1:0] x1_out;
  reg  [DATAWIDTH*L1_NUM_NEURONS-1:0] hold_1;
  reg  [DATAWIDTH-1:0]                out_1;
  reg                                 valid_1;

  layer_1 #(
    .NUM_INPUTS     (L1_NUM_INPUTS),
    .DATAWIDTH      (DATAWIDTH),
    .WEIGHTINTWIDTH (WEIGHTINTWIDTH)
  ) l1 (
    .clk            (clk),
    .rst            (rst),
    .input_valid    (input_valid),
    .input_val      (input_val),
    .x_out          (x1_out),
    .o_valid        (o1_valid)
  );

  localparam IDLE = 0, SEND = 1;
  reg     state_1;
  integer count_1;

  always @(posedge clk) begin
    if (rst) begin
      state_1       <= IDLE;
      count_1       <= 0;
      valid_1       <= 0;
    end else begin
      case (state_1)
        IDLE: begin
          count_1   <= 0;
          valid_1   <= 0;
          if (o1_valid[0]) begin
            hold_1  <= x1_out;
            state_1 <= SEND;
          end
        end
        SEND: begin
          out_1     <= hold_1[DATAWIDTH-1:0];
          hold_1    <= hold_1 >> DATAWIDTH;
          count_1   <= count_1 + 1;
          valid_1   <= 1;
          if (count_1 == L1_NUM_NEURONS) begin
            state_1 <= IDLE;
            valid_1 <= 0;
          end
        end
      endcase
    end
  end

  wire [L2_NUM_NEURONS-1:0]           o2_valid;
  wire [DATAWIDTH*L2_NUM_NEURONS-1:0] x2_out;
  reg  [DATAWIDTH*L2_NUM_NEURONS-1:0] hold_2;
  reg  [DATAWIDTH-1:0]                out_2;
  reg                                 valid_2;

  layer_2 #(
    .NUM_INPUTS     (L2_NUM_INPUTS),
    .DATAWIDTH      (DATAWIDTH),
    .WEIGHTINTWIDTH (WEIGHTINTWIDTH)
  ) l2 (
    .clk            (clk),
    .rst            (rst),
    .input_valid    (valid_1),
    .input_val      (out_1),
    .x_out          (x2_out),
    .o_valid        (o2_valid)
  );

  reg     state_2;
  integer count_2;

  always @(posedge clk) begin
    if (rst) begin
      state_2       <= IDLE;
      count_2       <= 0;
      valid_2       <= 0;
    end else begin
      case (state_2)
        IDLE: begin
          count_2   <= 0;
          valid_2   <= 0;
          if (o2_valid[0]) begin
            hold_2  <= x2_out;
            state_2 <= SEND;
          end
        end
        SEND: begin
          out_2     <= hold_2[DATAWIDTH-1:0];
          hold_2    <= hold_2 >> DATAWIDTH;
          count_2   <= count_2 + 1;
          valid_2   <= 1;
          if (count_2 == L2_NUM_NEURONS) begin
            state_2 <= IDLE;
            valid_2 <= 0;
          end
        end
      endcase
    end
  end

  wire [L3_NUM_NEURONS-1:0]           o3_valid;
  wire [DATAWIDTH*L3_NUM_NEURONS-1:0] x3_out;
  reg  [DATAWIDTH*L3_NUM_NEURONS-1:0] hold_3;
  reg  [DATAWIDTH-1:0]                out_3;
  reg                                 valid_3;

  layer_3 #(
    .NUM_INPUTS     (L3_NUM_INPUTS),
    .DATAWIDTH      (DATAWIDTH),
    .WEIGHTINTWIDTH (WEIGHTINTWIDTH)
  ) l3 (
    .clk            (clk),
    .rst            (rst),
    .input_valid    (valid_2),
    .input_val      (out_2),
    .x_out          (x3_out),
    .o_valid        (o3_valid)
  );

  reg     state_3;
  integer count_3;

  always @(posedge clk) begin
    if (rst) begin
      state_3       <= IDLE;
      count_3       <= 0;
      valid_3       <= 0;
    end else begin
      case (state_3)
        IDLE: begin
          count_3   <= 0;
          valid_3   <= 0;
          if (o3_valid[0]) begin
            hold_3  <= x3_out;
            state_3 <= SEND;
          end
        end
        SEND: begin
          out_3     <= hold_3[DATAWIDTH-1:0];
          hold_3    <= hold_3 >> DATAWIDTH;
          count_3   <= count_3 + 1;
          valid_3   <= 1;
          if (count_3 == L3_NUM_NEURONS) begin
            state_3 <= IDLE;
            valid_3 <= 0;
          end
        end
      endcase
    end
  end

  wire [L4_NUM_NEURONS-1:0]           o4_valid;
  wire [DATAWIDTH*L4_NUM_NEURONS-1:0] x4_out;
  reg  [DATAWIDTH*L3_NUM_NEURONS-1:0] hold_4;
  reg  [DATAWIDTH-1:0]                out_4;
  reg                                 valid_4;

  layer_4 #(
    .NUM_INPUTS     (L4_NUM_INPUTS),
    .DATAWIDTH      (DATAWIDTH),
    .WEIGHTINTWIDTH (WEIGHTINTWIDTH)
  ) l4 (
    .clk            (clk),
    .rst            (rst),
    .input_valid    (valid_3),
    .input_val      (out_3),
    .x_out          (x4_out),
    .o_valid        (o4_valid)
  );
  
//  reg     state_4;
//  integer count_4;
  
//  always @(posedge clk) begin
//    if (rst) begin
//      state_4       <= IDLE;
//      count_4       <= 0;
//      valid_4       <= 0;
//    end else begin
//      case (state_4)
//        IDLE: begin
//          count_4   <= 0;
//          valid_4   <= 0;
//          if (o4_valid[0]) begin
//            hold_4  <= x4_out;
//            state_4 <= SEND;
//          end
//        end
//        SEND: begin
//          out_4     <= hold_4[DATAWIDTH-1:0];
//          hold_4    <= hold_4 >> DATAWIDTH;
//          count_4   <= count_4 + 1;
//          valid_4   <= 1;
//          if (count_4 == L4_NUM_NEURONS) begin
//            state_4 <= IDLE;
//            valid_4 <= 0;
//          end
//        end
//      endcase
//    end
//  end
  
  

  maxfinder #(
    .NUM_INPUT      (L4_NUM_NEURONS),
    .INPUT_WIDTH    (DATAWIDTH)
  ) mf (
    .i_clk          (clk),
    .i_data         (x4_out),
    .i_valid        (o4_valid),
    .o_data         (out),
    .o_data_valid   (out_valid)
  );

endmodule
