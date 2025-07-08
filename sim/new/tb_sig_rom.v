`timescale 1ns / 1ps

module tb_sig_rom;

  localparam INWIDTH   = 6;
  localparam DATAWIDTH = 16;

  reg                   clk;
  reg  [INWIDTH-1:0]    x;
  wire [DATAWIDTH-1:0]  out;

  sig_rom #(
    .INWIDTH   (INWIDTH),
    .DATAWIDTH (DATAWIDTH)
  ) dut (
    .clk (clk),
    .x   (x),
    .out (out)
  );

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    x = 0;
    #10;

    repeat (10) begin
      @(posedge clk);
      x <= x + 1;
    end

    #20 $finish;
  end

  initial begin
    $display("Time\t x\t out");
    $monitor("%0t\t %0d\t %0d", $time, $signed(x), $signed(out));
  end

endmodule
