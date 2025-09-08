`timescale 1ns / 1ps

module tb_weight_memory;

  localparam NUMWEIGHT     = 10;
  localparam ADDRESSWIDTH  = $clog2(NUMWEIGHT);
  localparam DATAWIDTH     = 16;
  localparam WEIGHTFILE    = "/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/myProject1/myProject1.sim/sim_1/behav/xsim/w_4_9.mif";

  reg                        clk;
  reg                        ren;
  reg  [ADDRESSWIDTH-1:0]    radd;
  wire [DATAWIDTH-1:0]       wout;

  weight_memory #(
    .NUMWEIGHT     (NUMWEIGHT),
    .ADDRESSWIDTH  (ADDRESSWIDTH),
    .DATAWIDTH     (DATAWIDTH),
    .WEIGHTFILE    (WEIGHTFILE)
  ) dut (
    .clk           (clk),
    .ren           (ren),
    .radd          (radd),
    .wout          (wout)
  );

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    ren  = 0;
    radd = 0;

    #20;
    ren = 1;

    repeat (NUMWEIGHT) begin
      @(posedge clk);
      radd <= radd + 1;
    end

    @(posedge clk);
    ren <= 0;

    #20 $finish;
  end

  initial begin
    $display("Time\t radd\t wout");
    $monitor("%0t\t %0d\t %0d", $time, radd, $signed(wout));
  end

endmodule
