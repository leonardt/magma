// Module `Foo` defined externally
module Main (
    input [4:0] I [4:0],
    output [4:0] O [4:0]
);
wire [4:0] Foo_inst0_O [4:0];
wire [24:0] x;
wire [4:0] Foo_inst0_I [4:0];
assign Foo_inst0_I[4] = I[4];
assign Foo_inst0_I[3] = I[3];
assign Foo_inst0_I[2] = I[2];
assign Foo_inst0_I[1] = I[1];
assign Foo_inst0_I[0] = I[0];
Foo Foo_inst0 (
    .I(Foo_inst0_I),
    .O(Foo_inst0_O)
);
assign x = {Foo_inst0_O[4],Foo_inst0_O[3],Foo_inst0_O[2],Foo_inst0_O[1],Foo_inst0_O[0]};
assign O[4] = x[24:20];
assign O[3] = x[19:15];
assign O[2] = x[14:10];
assign O[1] = x[9:5];
assign O[0] = x[4:0];
endmodule

