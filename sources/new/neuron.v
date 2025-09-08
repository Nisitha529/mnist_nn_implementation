`timescale 1ns / 1ps

module neuron_1 #(parameter layerNo=0,BIAS = 0,neuronNo=0,NUM_INPUTS=784,DATAWIDTH=16,sigmoidSize=5,WEIGHTINTWIDTH=1,actType="relu",biasFile="",WEIGHTFILE="")(
    input           clk,
    input           rst,
    input [dataWidth-1:0]    input_val,
    input           input_valid,
    input           weightValid,
    input           biasValid,
    input [31:0]    weightValue,
    input [31:0]    biasValue,
    input [31:0]    config_layer_num,
    input [31:0]    config_neuron_num,
    output[dataWidth-1:0]    out,
    output reg      out_valid   
    );
    
    localparam weightFile     = WEIGHTFILE;
    localparam weightIntWidth = WEIGHTINTWIDTH;
    localparam dataWidth      = DATAWIDTH;
    localparam numWeight      = NUM_INPUTS;
    parameter addressWidth    = $clog2(numWeight);
    
    reg         wen;
    wire        ren;                // read_en
    reg [addressWidth-1:0] w_addr;
    reg [addressWidth:0]   r_addr;  // input_index - read address has to reach until numWeight hence width is 1 bit more
    reg [dataWidth-1:0]  w_in;
    wire [dataWidth-1:0] w_out;     // weight
    reg [2*dataWidth-1:0]  mul;     // product
    reg [2*dataWidth-1:0]  sum;
    reg [2*dataWidth-1:0]  bias;
    reg [31:0]    biasReg[0:0];     // BIAS
    reg         weight_valid;       // input_valid_d1
    reg         mult_valid;         // input_valid_d2
    wire        mux_valid;
    reg         sigValid; 
    wire [2*dataWidth:0] comboAdd;  // combo_sum
    wire [2*dataWidth:0] BiasAdd;   // biased_sum
    reg  [dataWidth-1:0] myinputd;  // input_reg
    reg muxValid_d;
    reg muxValid_f;
    reg addr=0;

   //Loading weight values into the momory
    always @(posedge clk)
    begin
        if(rst)
        begin
            w_addr <= {addressWidth{1'b1}};
            wen <=0;
        end
        else if(weightValid & (config_layer_num==layerNo) & (config_neuron_num==neuronNo))
        begin
            w_in <= weightValue;
            w_addr <= w_addr + 1;
            wen <= 1;
        end
        else
            wen <= 0;
    end
	
    assign mux_valid = mult_valid;
    assign comboAdd = mul + sum;
    assign BiasAdd = bias + sum;
    assign ren = input_valid;
    
	`ifdef pretrained
		initial
		begin
			$readmemb(biasFile,biasReg);
		end
		always @(posedge clk)
		begin
            bias <= {biasReg[addr][dataWidth-1:0],{dataWidth{1'b0}}};
        end
	`else
		always @(posedge clk)
		begin
			if(biasValid & (config_layer_num==layerNo) & (config_neuron_num==neuronNo))
			begin
				bias <= {biasValue[dataWidth-1:0],{dataWidth{1'b0}}};
			end
		end
	`endif
    
    
    always @(posedge clk)
    begin
        if(rst|out_valid)
            r_addr <= 0;
        else if(input_valid)
            r_addr <= r_addr + 1;
    end
    
    always @(posedge clk)
    begin
        mul  <= $signed(myinputd) * $signed(w_out);
    end
    
    
    always @(posedge clk)
    begin
        if(rst|out_valid)
            sum <= 0;
        else if((r_addr == numWeight) & muxValid_f)
        begin
            if(!bias[2*dataWidth-1] &!sum[2*dataWidth-1] & BiasAdd[2*dataWidth-1]) //If bias and sum are positive and after adding bias to sum, if sign bit becomes 1, saturate
            begin
                sum[2*dataWidth-1] <= 1'b0;
                sum[2*dataWidth-2:0] <= {2*dataWidth-1{1'b1}};
            end
            else if(bias[2*dataWidth-1] & sum[2*dataWidth-1] &  !BiasAdd[2*dataWidth-1]) //If bias and sum are negative and after addition if sign bit is 0, saturate
            begin
                sum[2*dataWidth-1] <= 1'b1;
                sum[2*dataWidth-2:0] <= {2*dataWidth-1{1'b0}};
            end
            else
                sum <= BiasAdd; 
        end
        else if(mux_valid)
        begin
            if(!mul[2*dataWidth-1] & !sum[2*dataWidth-1] & comboAdd[2*dataWidth-1])
            begin
                sum[2*dataWidth-1] <= 1'b0;
                sum[2*dataWidth-2:0] <= {2*dataWidth-1{1'b1}};
            end
            else if(mul[2*dataWidth-1] & sum[2*dataWidth-1] & !comboAdd[2*dataWidth-1])
            begin
                sum[2*dataWidth-1] <= 1'b1;
                sum[2*dataWidth-2:0] <= {2*dataWidth-1{1'b0}};
            end
            else
                sum <= comboAdd; 
        end
    end
    
    always @(posedge clk)
    begin
        myinputd     <= input_val;
        weight_valid <= input_valid;
        mult_valid   <= weight_valid;
        
        sigValid  <= ((r_addr == numWeight) & muxValid_f) ? 1'b1 : 1'b0;
        out_valid <= sigValid;
        muxValid_d <= mux_valid;
        muxValid_f <= !mux_valid & muxValid_d;
    end
    
    
    
  weight_memory #(
    .NUMWEIGHT     (NUM_INPUTS),
    .ADDRESSWIDTH  (addressWidth),
    .DATAWIDTH     (DATAWIDTH),
    .WEIGHTFILE    (WEIGHTFILE)
  ) weight_mem (
    .clk           (clk),
    .ren           (ren),
    .radd          (r_addr),
    .wout          (w_out)
  );
    
	generate
		if(actType == "sigmoid")
		begin:siginst
		//Instantiation of ROM for sigmoid
			Sig_ROM #(.inWidth(sigmoidSize),.dataWidth(dataWidth)) s1(
			.clk(clk),
			.x(sum[2*dataWidth-1-:sigmoidSize]),
			.out(out)
		);
		end
		else
		begin:ReLUinst
			relu #(.DATAWIDTH(dataWidth),.WEIGHTINTWIDTH(weightIntWidth)) s1 (
			.clk(clk),
			.x(sum),
			.out(out)
		);
		end
	endgenerate

    `ifdef DEBUG
    always @(posedge clk)
    begin
        if(out_valid)
            $display(neuronNo,,,,"%b",out);
    end
    `endif
endmodule

//module neuron_1 #(
//  parameter NUM_INPUTS      = 784,
//  parameter DATAWIDTH       = 16,
//  parameter WEIGHTINTWIDTH  = 1,
//  parameter BIAS            = 0,
//  parameter WEIGHTFILE      = ""
//)(
//  input                      clk,
//  input                      rst,
//  input  [DATAWIDTH-1:0]     input_val,
//  input                      input_valid,
//  output [DATAWIDTH-1:0]     out,
//  output reg                 out_valid
//);

//  localparam ADDR_WIDTH = $clog2(NUM_INPUTS);

//  reg  [ADDR_WIDTH:0]        input_index;
//  reg  [DATAWIDTH-1:0]       input_reg;
//  wire [DATAWIDTH-1:0]       weight;
//  reg  [2*DATAWIDTH-1:0]     product;
//  reg  [2*DATAWIDTH-1:0]     sum;
//  reg  [2*DATAWIDTH-1:0]     bias;
//  wire                       read_en;
//  wire [2*DATAWIDTH:0]       combo_sum;
//  wire [2*DATAWIDTH:0]       biased_sum;
//  reg                        input_valid_d1;
//  reg                        input_valid_d2;
//  reg                        end_of_dot;
//  reg                        end_of_dot_d;

//  initial begin
//    bias = {BIAS[DATAWIDTH-1:0], {DATAWIDTH{1'b0}}};
//  end

//  assign read_en    = input_valid;
//  assign combo_sum  = sum + product;
//  assign biased_sum = sum + bias;

//  always @(posedge clk) begin
//    if (rst | out_valid)
//      input_index <= 0;
//    else if (input_valid)
//      input_index <= input_index + 1;
//  end

//  always @(posedge clk) begin
//    product <= $signed(input_reg) * $signed(weight);
//  end

//  always @(posedge clk) begin
//    if (rst | out_valid)
//      sum <= 0;
//    else if ((input_index == NUM_INPUTS) && end_of_dot_d) begin
//      if (!bias[2*DATAWIDTH-1] && !sum[2*DATAWIDTH-1] && biased_sum[2*DATAWIDTH-1])
//        sum <= {1'b0, {2*DATAWIDTH-1{1'b1}}};
//      else if (bias[2*DATAWIDTH-1] && sum[2*DATAWIDTH-1] && !biased_sum[2*DATAWIDTH-1])
//        sum <= {1'b1, {2*DATAWIDTH-1{1'b0}}};
//      else
//        sum <= biased_sum;
//    end else if (input_valid_d2) begin
//      if (!product[2*DATAWIDTH-1] && !sum[2*DATAWIDTH-1] && combo_sum[2*DATAWIDTH-1])
//        sum <= {1'b0, {2*DATAWIDTH-1{1'b1}}};
//      else if (product[2*DATAWIDTH-1] && sum[2*DATAWIDTH-1] && !combo_sum[2*DATAWIDTH-1])
//        sum <= {1'b1, {2*DATAWIDTH-1{1'b0}}};
//      else
//        sum <= combo_sum;
//    end
//  end

//  always @(posedge clk) begin
//    input_reg      <= input_val;
//    input_valid_d1 <= input_valid;
//    input_valid_d2 <= input_valid_d1;
//    end_of_dot     <= (input_index == NUM_INPUTS);
//    end_of_dot_d   <= !input_valid && end_of_dot;
//    out_valid      <= end_of_dot_d;
//  end

//  weight_memory #(
//    .NUMWEIGHT     (NUM_INPUTS),
//    .ADDRESSWIDTH  (ADDR_WIDTH),
//    .DATAWIDTH     (DATAWIDTH),
//    .WEIGHTFILE    (WEIGHTFILE)
//  ) weight_mem (
//    .clk           (clk),
//    .ren           (read_en),
//    .radd          (input_index),
//    .wout          (weight)
//  );

//  relu #(
//    .DATAWIDTH      (DATAWIDTH),
//    .WEIGHTINTWIDTH (WEIGHTINTWIDTH)
//  ) relu_act (
//    .clk            (clk),
//    .x              (sum),
//    .out            (out)
//  );

//endmodule
