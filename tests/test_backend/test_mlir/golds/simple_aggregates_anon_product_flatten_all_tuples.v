// Generated by CIRCT firtool-1.48.0-34-g7018fb13b
module simple_aggregates_anon_product(
  input  [7:0] a_x,
               a_y,
  output [7:0] y_x,
               y_y
);

  assign y_x = ~a_x;
  assign y_y = ~a_y;
endmodule

