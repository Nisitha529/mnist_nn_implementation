`timescale 1ns / 1ps

module tb_relu;

  localparam DATAWIDTH      = 16;
  localparam WEIGHTINTWIDTH = 4;

  reg                        clk;
  reg  [2*DATAWIDTH-1:0]     x;
  wire [DATAWIDTH-1:0]       out;

  relu #(
    .DATAWIDTH      (DATAWIDTH),
    .WEIGHTINTWIDTH (WEIGHTINTWIDTH)
  ) dut (
    .clk            (clk),
    .x              (x),
    .out            (out)
  );

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    $display("Time\t\t x\t\t\t out");
    $monitor("%t\t %h\t %h", $time, x, out);

    x = -32'sd1000;
    @(posedge clk);

    x = 32'sd0;
    @(posedge clk);

    x = 32'sd1024;
    @(posedge clk);

    x = 32'sd131072;
    @(posedge clk);

    x = {1'b0, {(2*DATAWIDTH-1){1'b1}}};
    @(posedge clk);

    #10 $finish;
  end

endmodule
