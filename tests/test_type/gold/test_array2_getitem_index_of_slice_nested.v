module mantle_liftArrT__tBit21 (
    input [1:0] in,
    output [1:0] out [0:0]
);
assign out[0] = in;
endmodule

module mantle_concatNArrT__Ns1__t_childBitIn2 (
    input [1:0] in0 [0:0],
    output [1:0] out [0:0]
);
assign out[0] = in0[0];
endmodule

module mantle_concatNArrT__Ns11__t_childBitIn2 (
    input [1:0] in0 [0:0],
    input [1:0] in1 [0:0],
    output [1:0] out [1:0]
);
assign out[1] = in1[0];
assign out[0] = in0[0];
endmodule

module Foo (
    input [1:0] I [1:0],
    output [1:0] O [1:0]
);
wire [1:0] ConcatN_inst0_out [1:0];
wire [1:0] ConcatN_inst1_out [0:0];
wire [1:0] Lift_inst0_out [0:0];
wire [1:0] Lift_inst1_out [0:0];
wire [1:0] ConcatN_inst0_in0 [0:0];
assign ConcatN_inst0_in0[0] = Lift_inst0_out[0];
wire [1:0] ConcatN_inst0_in1 [0:0];
assign ConcatN_inst0_in1[0] = ConcatN_inst1_out[0];
mantle_concatNArrT__Ns11__t_childBitIn2 ConcatN_inst0 (
    .in0(ConcatN_inst0_in0),
    .in1(ConcatN_inst0_in1),
    .out(ConcatN_inst0_out)
);
wire [1:0] ConcatN_inst1_in0 [0:0];
assign ConcatN_inst1_in0[0] = Lift_inst1_out[0];
mantle_concatNArrT__Ns1__t_childBitIn2 ConcatN_inst1 (
    .in0(ConcatN_inst1_in0),
    .out(ConcatN_inst1_out)
);
mantle_liftArrT__tBit21 Lift_inst0 (
    .in(I[1]),
    .out(Lift_inst0_out)
);
mantle_liftArrT__tBit21 Lift_inst1 (
    .in(I[0]),
    .out(Lift_inst1_out)
);
assign O[1] = ConcatN_inst0_out[1];
assign O[0] = ConcatN_inst0_out[0];
endmodule

