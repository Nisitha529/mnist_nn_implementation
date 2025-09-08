`timescale 1ns / 1ps

module weight_memory #(
  parameter NUMWEIGHT     = 3,
  parameter NEURONNO      = 5,
  parameter LAYERNO       = 1,
  parameter ADDRESSWIDTH  = 10,
  parameter DATAWIDTH     = 16,
  parameter WEIGHTFILE    = "w_1_15.mif"
)(
  input                         clk,
  input                         ren,
  input      [ADDRESSWIDTH-1:0] radd,
  output reg [DATAWIDTH-1:0]    wout
);

  reg [DATAWIDTH-1:0] mem [NUMWEIGHT-1 : 0];

  initial begin
    $readmemb(WEIGHTFILE, mem);
  end

  always @(posedge clk) begin
    if (ren) begin
      wout <= mem[radd];
    end
  end

endmodule
