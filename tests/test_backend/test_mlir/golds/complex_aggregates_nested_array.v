// Generated by CIRCT circtorg-0.0.0-1773-g7abbc4313
module complex_aggregates_nested_array(
  input  [1:0][2:0][3:0] a,
  output [1:0][2:0][3:0] y
);

  assign y =
    {{{{{a[1'h1][2'h2][3] | a[1'h0][2'h0][0],
         a[1'h1][2'h2][2] | a[1'h0][2'h0][1],
         a[1'h1][2'h2][1] | a[1'h0][2'h0][2],
         a[1'h1][2'h2][0] | a[1'h0][2'h0][3]}},
       {{a[1'h1][2'h1][3] | a[1'h0][2'h1][0],
         a[1'h1][2'h1][2] | a[1'h0][2'h1][1],
         a[1'h1][2'h1][1] | a[1'h0][2'h1][2],
         a[1'h1][2'h1][0] | a[1'h0][2'h1][3]}},
       {{a[1'h1][2'h0][3] | a[1'h0][2'h2][0],
         a[1'h1][2'h0][2] | a[1'h0][2'h2][1],
         a[1'h1][2'h0][1] | a[1'h0][2'h2][2],
         a[1'h1][2'h0][0] | a[1'h0][2'h2][3]}}}},
     {{{{a[1'h0][2'h2][3] | a[1'h1][2'h0][0],
         a[1'h0][2'h2][2] | a[1'h1][2'h0][1],
         a[1'h0][2'h2][1] | a[1'h1][2'h0][2],
         a[1'h0][2'h2][0] | a[1'h1][2'h0][3]}},
       {{a[1'h0][2'h1][3] | a[1'h1][2'h1][0],
         a[1'h0][2'h1][2] | a[1'h1][2'h1][1],
         a[1'h0][2'h1][1] | a[1'h1][2'h1][2],
         a[1'h0][2'h1][0] | a[1'h1][2'h1][3]}},
       {{a[1'h0][2'h0][3] | a[1'h1][2'h2][0],
         a[1'h0][2'h0][2] | a[1'h1][2'h2][1],
         a[1'h0][2'h0][1] | a[1'h1][2'h2][2],
         a[1'h0][2'h0][0] | a[1'h1][2'h2][3]}}}}};
endmodule

