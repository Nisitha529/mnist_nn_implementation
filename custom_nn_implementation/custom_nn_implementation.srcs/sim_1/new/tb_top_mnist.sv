`timescale 1ns / 1ps

`define pretrained
`define numLayers 5
`define dataWidth 16
`define numNeuronLayer1 30
`define numWeightLayer1 784
`define Layer1ActType "relu"
`define numNeuronLayer2 30
`define numWeightLayer2 30
`define Layer2ActType "relu"
`define numNeuronLayer3 10
`define numWeightLayer3 30
`define Layer3ActType "relu"
`define numNeuronLayer4 10
`define numWeightLayer4 10
`define Layer4ActType "relu"
`define numNeuronLayer5 10
`define numWeightLayer5 10
`define Layer5ActType "hardmax"
`define sigmoidSize 5
`define weightIntWidth 4

`define MaxTestSamples 100

module top_zynet();

    reg                    reset;
    reg                    clock;
    
    reg   [`dataWidth-1:0] in;
    reg                    in_valid;
    reg   [`dataWidth-1:0] in_mem [784:0];
    
    string                 fileName; 
    
    reg                    s_axi_awvalid;
    reg    [31:0]          s_axi_awaddr;
    wire                   s_axi_awready;
    
    reg    [31:0]          s_axi_wdata;
    reg                    s_axi_wvalid;
    wire                   s_axi_wready;
    wire                   s_axi_bvalid;
    reg                    s_axi_bready;
    
    wire                   intr;
    
    reg    [31:0]          axiRdData;
    reg    [31:0]          s_axi_araddr;
    wire   [31:0]          s_axi_rdata;
    reg                    s_axi_arvalid;
    wire                   s_axi_arready;
    wire                   s_axi_rvalid;
    reg                    s_axi_rready;
    
    reg [`dataWidth-1:0]   expected;

    integer right        = 0;
    integer wrong        = 0;
    integer testDataCount;
    integer start;
    
    top_mnist top_mnist(
    .s_axi_aclk         (clock),
    .s_axi_aresetn      (reset),
    
    .s_axi_awaddr       (s_axi_awaddr),
    .s_axi_awprot       (0),
    .s_axi_awvalid      (s_axi_awvalid),
    .s_axi_awready      (s_axi_awready),
    
    .s_axi_wdata        (s_axi_wdata),
    .s_axi_wstrb        (4'hF),
    .s_axi_wvalid       (s_axi_wvalid),
    .s_axi_wready       (s_axi_wready),
    
    .s_axi_bresp        (),
    .s_axi_bvalid       (s_axi_bvalid),
    .s_axi_bready       (s_axi_bready),
    .s_axi_araddr       (s_axi_araddr),
    .s_axi_arprot       (0),
    .s_axi_arvalid      (s_axi_arvalid),
    .s_axi_arready      (s_axi_arready),
    .s_axi_rdata        (s_axi_rdata),
    .s_axi_rresp        (),
    .s_axi_rvalid       (s_axi_rvalid),
    .s_axi_rready       (s_axi_rready),
    
    .axis_in_data       (in),
    .axis_in_data_valid (in_valid),
    .axis_in_data_ready (),
    
    .intr               (intr)
    );
    
    initial clock     = 1'b0;
    always #5 clock   = ~clock;
    
    initial begin
        s_axi_awvalid = 1'b0;
        s_axi_bready  = 1'b0;
        s_axi_wvalid  = 1'b0;
        s_axi_arvalid = 1'b0;
    end
        
    always @(posedge clock) begin
        s_axi_bready <= s_axi_bvalid;
        s_axi_rready <= s_axi_rvalid;
    end
    
    task writeAxi(input [31:0] address, input [31:0] data);
        @(posedge clock);
        s_axi_awvalid <= 1'b1;
        s_axi_awaddr  <= address;
        s_axi_wdata   <= data;
        s_axi_wvalid  <= 1'b1;
        wait(s_axi_wready);
        
        @(posedge clock);
        s_axi_awvalid <= 1'b0;
        s_axi_wvalid  <= 1'b0;
        
        @(posedge clock);
    endtask
    
    task readAxi(input [31:0] address);
        @(posedge clock);
        s_axi_arvalid <= 1'b1;
        s_axi_araddr  <= address;
        wait(s_axi_arready);
        
        @(posedge clock);
        s_axi_arvalid <= 1'b0;
        wait(s_axi_rvalid);
        
        @(posedge clock);
        axiRdData     <= s_axi_rdata;
        
        @(posedge clock);
    endtask
    
    task sendData();
        integer t;
        begin
            fileName = $sformatf("/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/test_data_%04d.txt", testDataCount);
            $readmemb(fileName, in_mem);
            repeat(3) @(posedge clock);
            
            for (t=0; t <784; t=t+1) begin
                @(posedge clock);
                in       <= in_mem[t];
                in_valid <= 1;
            end 
            
            @(posedge clock);
            
            in_valid     <= 0;
            expected     =  in_mem[784];  
        end
    endtask
   
    initial begin
        reset    = 0;
        in_valid = 0;
        #100;
        
        reset    = 1;
        #100;
        
        writeAxi(28, 0);  
        start = $time;

        $display("Configuration completed in %0d ns", $time - start);
        start = $time;
        for(testDataCount=0; testDataCount<`MaxTestSamples; testDataCount=testDataCount+1) begin
            sendData();
            
            @(posedge intr);
            readAxi(8);
            
            if(axiRdData == expected) right = right + 1;
            $display("%0d. Accuracy: %f%%, Detected: %0x, Expected: %x", testDataCount+1, right*100.0/(testDataCount+1), axiRdData, expected);
        end
        $display("Final Accuracy: %f%%", right*100.0/testDataCount);
        $stop;
    end

endmodule