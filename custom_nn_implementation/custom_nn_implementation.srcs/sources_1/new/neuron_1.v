`timescale 1ns / 1ps
module neuron #(
  parameter NUM_INPUTS      = 784,
  parameter DATAWIDTH       = 16,
  parameter WEIGHTINTWIDTH  = 1,
  parameter BIAS            = 0,
  parameter WEIGHTFILE      = ""
)(
  input                      clk,
  input                      rst,
  
  input  [DATAWIDTH-1:0]     input_val,
  input                      input_valid,
  
  output [DATAWIDTH-1:0]     out,
  output reg                 out_valid
);
    
    localparam ADDR_WIDTH = $clog2(NUM_INPUTS);
    
    wire                   read_en;      
    wire [DATAWIDTH-1:0]   weight;       
    wire                   mux_valid;
    wire [2*DATAWIDTH:0]   combo_sum;    
    wire [2*DATAWIDTH:0]   biased_sum;   
    
    reg  [ADDR_WIDTH:0]    input_index;  
    (* use_dsp48 = "yes" *)reg  [2*DATAWIDTH-1:0] product;     
    reg  [2*DATAWIDTH-1:0] sum;
    reg  [2*DATAWIDTH-1:0] bias;
    reg                    input_valid_d1;       
    reg                    input_valid_d2;         
    reg                    sigvalid; 
    reg  [DATAWIDTH-1:0]   input_reg;  // input_reg
    reg                    muxvalid_d;
    reg                    muxvalid_f;
    reg                    addr=0;
	
    assign mux_valid  = input_valid_d2;
    assign combo_sum  = product + sum;
    assign biased_sum = bias + sum;
    assign read_en    = input_valid;
    
	initial begin
	  bias = {BIAS[DATAWIDTH-1:0], {DATAWIDTH{1'b0}}};
	end
    
    always @(posedge clk)
    begin
        if(rst|out_valid)
            input_index <= 0;
        else if(input_valid)
            input_index <= input_index + 1;
    end
    
    always @(posedge clk)
    begin
        product  <= $signed(input_reg) * $signed(weight);
    end
    
    
    always @(posedge clk) begin
    if(rst|out_valid)
      sum                      <= 0;
      else if((input_index == NUM_INPUTS) & muxvalid_f) begin
        if(!bias[2*DATAWIDTH-1] &!sum[2*DATAWIDTH-1] & biased_sum[2*DATAWIDTH-1]) begin//If bias and sum are positive and after adding bias to sum, if sign bit becomes 1, saturate
            sum[2*DATAWIDTH-1]   <= 1'b0;
            sum[2*DATAWIDTH-2:0] <= {2*DATAWIDTH-1{1'b1}};
        end else if(bias[2*DATAWIDTH-1] & sum[2*DATAWIDTH-1] &  !biased_sum[2*DATAWIDTH-1]) begin//If bias and sum are negative and after addition if sign bit is 0, saturate
            sum[2*DATAWIDTH-1]   <= 1'b1;
            sum[2*DATAWIDTH-2:0] <= {2*DATAWIDTH-1{1'b0}};
        end else
            sum <= biased_sum; 
      end else if(mux_valid) begin
        if(!product[2*DATAWIDTH-1] & !sum[2*DATAWIDTH-1] & combo_sum[2*DATAWIDTH-1]) begin
            sum[2*DATAWIDTH-1]   <= 1'b0;
            sum[2*DATAWIDTH-2:0] <= {2*DATAWIDTH-1{1'b1}};
        end else if(product[2*DATAWIDTH-1] & sum[2*DATAWIDTH-1] & !combo_sum[2*DATAWIDTH-1]) begin
            sum[2*DATAWIDTH-1]   <= 1'b1;
            sum[2*DATAWIDTH-2:0] <= {2*DATAWIDTH-1{1'b0}};
        end else
            sum <= combo_sum; 
      end
    end

//  always @(posedge clk) begin
//    if (rst | out_valid) begin
//      sum <= 0;
//    end
//    else if ((input_index == NUM_INPUTS) && muxvalid_f) begin
//      sum <= (biased_sum[2*DATAWIDTH] != biased_sum[2*DATAWIDTH-1]) ? {biased_sum[2*DATAWIDTH], {2*DATAWIDTH-1{biased_sum[2*DATAWIDTH-1]}}} : biased_sum;
//    end
//    else if (mux_valid) begin
//      sum <= (combo_sum[2*DATAWIDTH] != combo_sum[2*DATAWIDTH-1]) ? {combo_sum[2*DATAWIDTH], {2*DATAWIDTH-1{combo_sum[2*DATAWIDTH-1]}}} : combo_sum;
//    end
//  end
    
    always @(posedge clk) begin
      input_reg      <= input_val;
      input_valid_d1 <= input_valid;
      input_valid_d2 <= input_valid_d1;
    
      sigvalid       <= ((input_index == NUM_INPUTS) & muxvalid_f) ? 1'b1 : 1'b0;
      out_valid      <= sigvalid;
      muxvalid_d     <= mux_valid;
      muxvalid_f     <= !mux_valid & muxvalid_d;
    end
    
  weight_memory #(
    .NUMWEIGHT     (NUM_INPUTS),
    .ADDRESSWIDTH  (ADDR_WIDTH),
    .DATAWIDTH     (DATAWIDTH),
    .WEIGHTFILE    (WEIGHTFILE)
  ) weight_mem (
    .clk           (clk),
    .ren           (read_en),
    .radd          (input_index),
    .wout          (weight)
  );
   
	
  relu #(
    .DATAWIDTH      (DATAWIDTH),
    .WEIGHTINTWIDTH (WEIGHTINTWIDTH)
  ) relu_act (
    .clk            (clk),
    .x              (sum),
    .out            (out)
  );

endmodule