`timescale 1ns / 1ps

module maxfinder #(
  parameter NUM_INPUT    = 10,
  parameter INPUT_WIDTH  = 16
)(
  input                                  i_clk,
  input      [NUM_INPUT*INPUT_WIDTH-1:0] i_data,
  input                                  i_valid,
  output reg [31:0]                      o_data,
  output reg                             o_data_valid
);

  reg [INPUT_WIDTH-1:0]              max_value;
  reg [NUM_INPUT*INPUT_WIDTH-1:0]    buffer;
  integer                            counter;

  always @(posedge i_clk) begin
    o_data_valid <= 1'b0;

    if (i_valid) begin
      max_value    <= i_data[INPUT_WIDTH-1:0];
      counter      <= 1;
      buffer       <= i_data;
      o_data       <= 0;
    end
    else if (counter == NUM_INPUT) begin
      counter      <= 0;
      o_data_valid <= 1'b1;
    end
    else if (counter != 0) begin
      if (buffer[counter*INPUT_WIDTH+:INPUT_WIDTH] > max_value) begin
        max_value <= buffer[counter*INPUT_WIDTH+:INPUT_WIDTH];
        o_data    <= counter;
      end
      counter <= counter + 1;
    end
  end

endmodule
