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

module Mux2xArray3_Bits8 (
    input [7:0] I0 [2:0],
    input [7:0] I1 [2:0],
    input S,
    output [7:0] O [2:0]
);
reg [23:0] coreir_commonlib_mux2x24_inst0_out_unq1;
always @(*) begin
if (S == 0) begin
    coreir_commonlib_mux2x24_inst0_out_unq1 = {I0[2][7:0],I0[1][7:0],I0[0][7:0]};
end else begin
    coreir_commonlib_mux2x24_inst0_out_unq1 = {I1[2][7:0],I1[1][7:0],I1[0][7:0]};
end
end

assign O[2] = coreir_commonlib_mux2x24_inst0_out_unq1[23:16];
assign O[1] = coreir_commonlib_mux2x24_inst0_out_unq1[15:8];
assign O[0] = coreir_commonlib_mux2x24_inst0_out_unq1[7:0];
endmodule

module Register (
    input [7:0] I [2:0],
    output [7:0] O [2:0],
    input CLK,
    input RESET
);
wire [7:0] Mux2xArray3_Bits8_inst0_O [2:0];
wire [23:0] reg_P24_inst0_out;
wire [7:0] Mux2xArray3_Bits8_inst0_I0 [2:0];
assign Mux2xArray3_Bits8_inst0_I0[2] = I[2];
assign Mux2xArray3_Bits8_inst0_I0[1] = I[1];
assign Mux2xArray3_Bits8_inst0_I0[0] = I[0];
wire [7:0] Mux2xArray3_Bits8_inst0_I1 [2:0];
assign Mux2xArray3_Bits8_inst0_I1[2] = 8'hbe;
assign Mux2xArray3_Bits8_inst0_I1[1] = 8'had;
assign Mux2xArray3_Bits8_inst0_I1[0] = 8'hde;
Mux2xArray3_Bits8 Mux2xArray3_Bits8_inst0 (
    .I0(Mux2xArray3_Bits8_inst0_I0),
    .I1(Mux2xArray3_Bits8_inst0_I1),
    .S(RESET),
    .O(Mux2xArray3_Bits8_inst0_O)
);
wire [23:0] reg_P24_inst0_in;
assign reg_P24_inst0_in = {Mux2xArray3_Bits8_inst0_O[2][7:0],Mux2xArray3_Bits8_inst0_O[1][7:0],Mux2xArray3_Bits8_inst0_O[0][7:0]};
coreir_reg #(
    .clk_posedge(1'b1),
    .init(24'hbeadde),
    .width(24)
) reg_P24_inst0 (
    .clk(CLK),
    .in(reg_P24_inst0_in),
    .out(reg_P24_inst0_out)
);
assign O[2] = reg_P24_inst0_out[23:16];
assign O[1] = reg_P24_inst0_out[15:8];
assign O[0] = reg_P24_inst0_out[7:0];
endmodule

module test_reg_of_nested_array (
    input [7:0] I [2:0],
    output [7:0] O [2:0],
    input CLK,
    input RESET
);
wire [7:0] Register_inst0_O [2:0];
wire [7:0] Register_inst0_I [2:0];
assign Register_inst0_I[2] = I[2];
assign Register_inst0_I[1] = I[1];
assign Register_inst0_I[0] = I[0];
Register Register_inst0 (
    .I(Register_inst0_I),
    .O(Register_inst0_O),
    .CLK(CLK),
    .RESET(RESET)
);
assign O[2] = Register_inst0_O[2];
assign O[1] = Register_inst0_O[1];
assign O[0] = Register_inst0_O[0];
endmodule

