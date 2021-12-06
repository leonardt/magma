// Module `Buf` defined externally
module coreir_term #(
    parameter width = 1
) (
    input [width-1:0] in
);

endmodule

module coreir_const #(
    parameter width = 1,
    parameter value = 1
) (
    output [width-1:0] out
);
  assign out = value;
endmodule

module main (
    output [1:0] O
);
wire [1:0] Buf_inst0_O;
wire [1:0] Const_inst0_out;
Buf Buf_inst0 (
    .I(Const_inst0_out),
    .O(Buf_inst0_O)
);
coreir_const #(
    .value(2'h1),
    .width(2)
) Const_inst0 (
    .out(Const_inst0_out)
);
coreir_term #(
    .width(2)
) term_inst0 (
    .in(Const_inst0_out)
);
assign O = Buf_inst0_O;
endmodule

