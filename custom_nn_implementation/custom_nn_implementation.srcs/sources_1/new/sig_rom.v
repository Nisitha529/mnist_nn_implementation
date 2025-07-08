`timescale 1ns / 1ps

module sig_rom #(
  parameter INWIDTH   = 10,
  parameter DATAWIDTH = 16
)(
  input                      clk,
  input      [INWIDTH-1:0]   x,
  output     [DATAWIDTH-1:0] out
);

  reg [DATAWIDTH-1:0] mem [0:(1 << INWIDTH)-1];
  reg [INWIDTH-1:0]   y;

  initial begin
    $readmemb("/media/nisitha/My_Passport/MOODLE/Vivado_projects/cnn_character_recognition/custom_cnn_implementation/custom_nn_implementation/custom_nn_implementation/custom_nn_implementation.srcs/sources_1/new/sigContent.mif", mem);
  end

  always @(posedge clk) begin
    if ($signed(x) >= 0)
      y <= x + (1 << (INWIDTH-1));
    else
      y <= x - (1 << (INWIDTH-1));
  end

  assign out = mem[y];

endmodule
