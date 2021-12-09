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

module coreir_mux #(
    parameter width = 1
) (
    input [width-1:0] in0,
    input [width-1:0] in1,
    input sel,
    output [width-1:0] out
);
  assign out = sel ? in1 : in0;
endmodule

module coreir_const #(
    parameter width = 1,
    parameter value = 1
) (
    output [width-1:0] out
);
  assign out = value;
endmodule

module commonlib_muxn__N2__width12 (
    input [11:0] in_data [1:0],
    input [0:0] in_sel,
    output [11:0] out
);
wire [11:0] _join_out;
coreir_mux #(
    .width(12)
) _join (
    .in0(in_data[0]),
    .in1(in_data[1]),
    .sel(in_sel[0]),
    .out(_join_out)
);
assign out = _join_out;
endmodule

module Mux2xTuplex_Bits8_y_Bits4 (
    input [7:0] I0_x,
    input [3:0] I0_y,
    input [7:0] I1_x,
    input [3:0] I1_y,
    output [7:0] O_x,
    output [3:0] O_y,
    input S
);
wire [11:0] coreir_commonlib_mux2x12_inst0_out;
wire [11:0] coreir_commonlib_mux2x12_inst0_in_data [1:0];
assign coreir_commonlib_mux2x12_inst0_in_data[1] = {I1_y[3],I1_y[2],I1_y[1],I1_y[0],I1_x[7],I1_x[6],I1_x[5],I1_x[4],I1_x[3],I1_x[2],I1_x[1],I1_x[0]};
assign coreir_commonlib_mux2x12_inst0_in_data[0] = {I0_y[3],I0_y[2],I0_y[1],I0_y[0],I0_x[7],I0_x[6],I0_x[5],I0_x[4],I0_x[3],I0_x[2],I0_x[1],I0_x[0]};
commonlib_muxn__N2__width12 coreir_commonlib_mux2x12_inst0 (
    .in_data(coreir_commonlib_mux2x12_inst0_in_data),
    .in_sel(S),
    .out(coreir_commonlib_mux2x12_inst0_out)
);
assign O_x = {coreir_commonlib_mux2x12_inst0_out[7],coreir_commonlib_mux2x12_inst0_out[6],coreir_commonlib_mux2x12_inst0_out[5],coreir_commonlib_mux2x12_inst0_out[4],coreir_commonlib_mux2x12_inst0_out[3],coreir_commonlib_mux2x12_inst0_out[2],coreir_commonlib_mux2x12_inst0_out[1],coreir_commonlib_mux2x12_inst0_out[0]};
assign O_y = {coreir_commonlib_mux2x12_inst0_out[11],coreir_commonlib_mux2x12_inst0_out[10],coreir_commonlib_mux2x12_inst0_out[9],coreir_commonlib_mux2x12_inst0_out[8]};
endmodule

module Register (
    input CLK,
    input [7:0] I_x,
    input [3:0] I_y,
    output [7:0] O_x,
    output [3:0] O_y,
    input RESET
);
wire [7:0] Mux2xTuplex_Bits8_y_Bits4_inst0_O_x;
wire [3:0] Mux2xTuplex_Bits8_y_Bits4_inst0_O_y;
wire [3:0] const_10_4_out;
wire [7:0] const_222_8_out;
wire [11:0] reg_P12_inst0_out;
Mux2xTuplex_Bits8_y_Bits4 Mux2xTuplex_Bits8_y_Bits4_inst0 (
    .I0_x(I_x),
    .I0_y(I_y),
    .I1_x(const_222_8_out),
    .I1_y(const_10_4_out),
    .O_x(Mux2xTuplex_Bits8_y_Bits4_inst0_O_x),
    .O_y(Mux2xTuplex_Bits8_y_Bits4_inst0_O_y),
    .S(RESET)
);
coreir_const #(
    .value(4'ha),
    .width(4)
) const_10_4 (
    .out(const_10_4_out)
);
coreir_const #(
    .value(8'hde),
    .width(8)
) const_222_8 (
    .out(const_222_8_out)
);
wire [11:0] reg_P12_inst0_in;
assign reg_P12_inst0_in = {Mux2xTuplex_Bits8_y_Bits4_inst0_O_y[3],Mux2xTuplex_Bits8_y_Bits4_inst0_O_y[2],Mux2xTuplex_Bits8_y_Bits4_inst0_O_y[1],Mux2xTuplex_Bits8_y_Bits4_inst0_O_y[0],Mux2xTuplex_Bits8_y_Bits4_inst0_O_x[7],Mux2xTuplex_Bits8_y_Bits4_inst0_O_x[6],Mux2xTuplex_Bits8_y_Bits4_inst0_O_x[5],Mux2xTuplex_Bits8_y_Bits4_inst0_O_x[4],Mux2xTuplex_Bits8_y_Bits4_inst0_O_x[3],Mux2xTuplex_Bits8_y_Bits4_inst0_O_x[2],Mux2xTuplex_Bits8_y_Bits4_inst0_O_x[1],Mux2xTuplex_Bits8_y_Bits4_inst0_O_x[0]};
coreir_reg #(
    .clk_posedge(1'b1),
    .init(12'hade),
    .width(12)
) reg_P12_inst0 (
    .clk(CLK),
    .in(reg_P12_inst0_in),
    .out(reg_P12_inst0_out)
);
assign O_x = {reg_P12_inst0_out[7],reg_P12_inst0_out[6],reg_P12_inst0_out[5],reg_P12_inst0_out[4],reg_P12_inst0_out[3],reg_P12_inst0_out[2],reg_P12_inst0_out[1],reg_P12_inst0_out[0]};
assign O_y = {reg_P12_inst0_out[11],reg_P12_inst0_out[10],reg_P12_inst0_out[9],reg_P12_inst0_out[8]};
endmodule

module test_reg_of_product (
    input CLK,
    input [7:0] I_x,
    input [3:0] I_y,
    output [7:0] O_x,
    output [3:0] O_y,
    input RESET
);
wire [7:0] Register_inst0_O_x;
wire [3:0] Register_inst0_O_y;
Register Register_inst0 (
    .CLK(CLK),
    .I_x(I_x),
    .I_y(I_y),
    .O_x(Register_inst0_O_x),
    .O_y(Register_inst0_O_y),
    .RESET(RESET)
);
assign O_x = Register_inst0_O_x;
assign O_y = Register_inst0_O_y;
endmodule

