module coreir_reg #(
    parameter width = 1,
    parameter clk_posedge = 1,
    parameter init = 1
) (
    input clk,
    input [width-1:0] in,
    output [width-1:0] out
);
  reg [width-1:0] outReg=init;
  wire real_clk;
  assign real_clk = clk_posedge ? clk : ~clk;
  always @(posedge real_clk) begin
    outReg <= in;
  end
  assign out = outReg;
endmodule

module Register (
    input I,
    output O,
    input CLK
);
wire [0:0] reg_P_inst0_out;
coreir_reg #(
    .clk_posedge(1'b1),
    .init(1'h0),
    .width(1)
) reg_P_inst0 (
    .clk(CLK),
    .in(I),
    .out(reg_P_inst0_out)
);
assign O = reg_P_inst0_out[0];
endmodule

module Mux2xTuplea_Tupleb__SequentialRegisterWrapperBit_c_Tuple_SequentialRegisterWrapperBit (
    input I0_a_b,
    input I0_c__0,
    input I1_a_b,
    input I1_c__0,
    output O_a_b,
    output O_c__0,
    input S
);
reg [1:0] coreir_commonlib_mux2x2_inst0_out;
always @(*) begin
if (S == 0) begin
    coreir_commonlib_mux2x2_inst0_out = {I0_c__0,I0_a_b};
end else begin
    coreir_commonlib_mux2x2_inst0_out = {I1_c__0,I1_a_b};
end
end

assign O_a_b = coreir_commonlib_mux2x2_inst0_out[0];
assign O_c__0 = coreir_commonlib_mux2x2_inst0_out[1];
endmodule

module Mux2xBit (
    input I0,
    input I1,
    input S,
    output O
);
reg [0:0] coreir_commonlib_mux2x1_inst0_out;
always @(*) begin
if (S == 0) begin
    coreir_commonlib_mux2x1_inst0_out = I0;
end else begin
    coreir_commonlib_mux2x1_inst0_out = I1;
end
end

assign O = coreir_commonlib_mux2x1_inst0_out[0];
endmodule

module Test (
    input CLK,
    output O_a_b,
    output O_c__0,
    input sel
);
wire Mux2xBit_inst0_O;
wire Register_inst0_O;
Mux2xBit Mux2xBit_inst0 (
    .I0(sel),
    .I1(sel),
    .S(sel),
    .O(Mux2xBit_inst0_O)
);
Mux2xTuplea_Tupleb__SequentialRegisterWrapperBit_c_Tuple_SequentialRegisterWrapperBit Mux2xTuplea_Tupleb__SequentialRegisterWrapperBit_c_Tuple_SequentialRegisterWrapperBit_inst0 (
    .I0_a_b(Register_inst0_O),
    .I0_c__0(Register_inst0_O),
    .I1_a_b(1'b0),
    .I1_c__0(1'b0),
    .O_a_b(O_a_b),
    .O_c__0(O_c__0),
    .S(sel)
);
Register Register_inst0 (
    .I(Mux2xBit_inst0_O),
    .O(Register_inst0_O),
    .CLK(CLK)
);
endmodule

