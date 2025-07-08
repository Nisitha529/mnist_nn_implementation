module relu #(
  parameter DATAWIDTH      = 16,
  parameter WEIGHTINTWIDTH = 4
)(
  input                        clk,
  input      [2*DATAWIDTH-1:0] x,
  output reg [DATAWIDTH-1:0]   out
);

always @(posedge clk) begin
  if ($signed(x) >= 0) begin
    if (|x[2*DATAWIDTH-1 -: WEIGHTINTWIDTH+1]) 
      out <= {1'b0, {(DATAWIDTH-1){1'b1}}};    
    else
      out <= x[2*DATAWIDTH-1 - WEIGHTINTWIDTH -: DATAWIDTH];
  end else begin
    out <= 0;
  end
end

endmodule
