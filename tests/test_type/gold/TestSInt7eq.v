module coreir_eq #(
    parameter width = 1
) (
    input [width-1:0] in0,
    input [width-1:0] in1,
    output out
);
  assign out = in0 == in1;
endmodule

module TestBinary (
    input [6:0] I0,
    input [6:0] I1,
    output O
);
wire magma_SInt_7_eq_inst0_out;
coreir_eq #(
    .width(7)
) magma_SInt_7_eq_inst0 (
    .in0(I0),
    .in1(I1),
    .out(magma_SInt_7_eq_inst0_out)
);
assign O = magma_SInt_7_eq_inst0_out;
endmodule

