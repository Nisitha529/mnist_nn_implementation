`timescale 1ns / 1ps

module top_mnist #(
  parameter DATAWIDTH          = 16,
  parameter L1_NUM_NEURONS     = 30,
  parameter L1_NUM_INPUTS      = 784,
  parameter L2_NUM_NEURONS     = 30,
  parameter L2_NUM_INPUTS      = 30,
  parameter L3_NUM_NEURONS     = 10,
  parameter L3_NUM_INPUTS      = 30,
  parameter L4_NUM_NEURONS     = 10,
  parameter L4_NUM_INPUTS      = 10,
  parameter WEIGHTINTWIDTH     = 4,
  
  parameter C_S_AXI_DATA_WIDTH = 32,
  parameter C_S_AXI_ADDR_WIDTH = 5
)(
  input                                      s_axi_aclk,
  input                                      s_axi_aresetn,
  
  input                                      axis_in_data_valid,
  input      [DATAWIDTH-1:0]                 axis_in_data,
  output                                     axis_in_data_ready,
  
  input wire [C_S_AXI_ADDR_WIDTH-1 : 0]      s_axi_awaddr,
  input wire [2 : 0]                         s_axi_awprot,
  input wire                                 s_axi_awvalid,
  output wire                                s_axi_awready,
  
  input  wire [C_S_AXI_DATA_WIDTH-1 : 0]     s_axi_wdata,
  input  wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] s_axi_wstrb,
  input  wire                                s_axi_wvalid,
  output wire                                s_axi_wready,
  
  output wire [1 : 0]                        s_axi_bresp,
  output wire                                s_axi_bvalid,
  input  wire                                s_axi_bready,
  input  wire [C_S_AXI_ADDR_WIDTH-1 : 0]     s_axi_araddr,
  input  wire [2 : 0]                        s_axi_arprot,
  input  wire                                s_axi_arvalid,
  output wire                                s_axi_arready,
  output wire [C_S_AXI_DATA_WIDTH-1 : 0]     s_axi_rdata,
  output wire [1 : 0]                        s_axi_rresp,
  output wire                                s_axi_rvalid,
  input  wire                                s_axi_rready,

  output wire                                intr
);

  wire [31:0] config_layer_num;
  wire [31:0] config_neuron_num;
  wire [31:0] weightValue;
  wire [31:0] biasValue;
  wire        weightValid;
  wire        biasValid;
  
  wire [31:0] out;
  wire        out_valid;

  wire        axi_rd_en;
  wire [31:0] axi_rd_data;
  wire        softReset;
  
  wire reset;

  assign intr               = out_valid;
  assign axis_in_data_ready = 1'b1;
  
  axi_lite_wrapper # ( 
    .C_S_AXI_DATA_WIDTH (C_S_AXI_DATA_WIDTH),
    .C_S_AXI_ADDR_WIDTH (C_S_AXI_ADDR_WIDTH)
  ) alw (
    .S_AXI_ACLK         (s_axi_aclk),
    .S_AXI_ARESETN      (s_axi_aresetn),
    
    .S_AXI_AWADDR       (s_axi_awaddr),
    .S_AXI_AWPROT       (s_axi_awprot),
    .S_AXI_AWVALID      (s_axi_awvalid),
    .S_AXI_AWREADY      (s_axi_awready),
    
    .S_AXI_WDATA        (s_axi_wdata),
    .S_AXI_WSTRB        (s_axi_wstrb),
    .S_AXI_WVALID       (s_axi_wvalid),
    .S_AXI_WREADY       (s_axi_wready),
    
    .S_AXI_BRESP        (s_axi_bresp),
    .S_AXI_BVALID       (s_axi_bvalid),
    .S_AXI_BREADY       (s_axi_bready),
    .S_AXI_ARADDR       (s_axi_araddr),
    .S_AXI_ARPROT       (s_axi_arprot),
    .S_AXI_ARVALID      (s_axi_arvalid),
    .S_AXI_ARREADY      (s_axi_arready),
    .S_AXI_RDATA        (s_axi_rdata),
    .S_AXI_RRESP        (s_axi_rresp),
    .S_AXI_RVALID       (s_axi_rvalid),
    .S_AXI_RREADY       (s_axi_rready),
    
    .layerNumber        (config_layer_num),
    .neuronNumber       (config_neuron_num),
    .weightValue        (weightValue),
    .weightValid        (weightValid),
    .biasValid          (biasValid),
    .biasValue          (biasValue),
    
    .nnOut_valid        (out_valid),
    .nnOut              (out),
    
    .axi_rd_en          (axi_rd_en),
    .axi_rd_data        (axi_rd_data),
    .softReset          (softReset)
  );
  
  assign reset = ~s_axi_aresetn|softReset;

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
    .clk            (s_axi_aclk),
    .rst            (reset),
    
    .input_valid    (axis_in_data_valid),
    .input_val      (axis_in_data),
    
    .x_out          (x1_out),
    .o_valid        (o1_valid)
  );

  localparam IDLE = 0, SEND = 1;
  reg     state_1;
  integer count_1;

  always @(posedge s_axi_aclk) begin
    if (reset) begin
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
  ) layer_2_01 (
    .clk            (s_axi_aclk),
    .rst            (reset),
    
    .input_valid    (valid_1),
    .input_val      (out_1),
    
    .x_out          (x2_out),
    .o_valid        (o2_valid)
  );

  reg     state_2;
  integer count_2;

  always @(posedge s_axi_aclk) begin
    if (reset) begin
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
  ) layer_3_01 (
    .clk            (s_axi_aclk),
    .rst            (reset),
    
    .input_valid    (valid_2),
    .input_val      (out_2),
    
    .x_out          (x3_out),
    .o_valid        (o3_valid)
  );

  reg     state_3;
  integer count_3;

  always @(posedge s_axi_aclk) begin
    if (reset) begin
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
  ) layer_4_01 (
    .clk            (s_axi_aclk),
    .rst            (reset),
    
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
//          if (&o4_valid[0]) begin
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
  ) maxfinder_01 (
    .i_clk          (s_axi_aclk),
    
    .i_data         (x4_out),
    .i_valid        (o4_valid),
    
    .o_data         (out),
    .o_data_valid   (out_valid)
  );

endmodule
