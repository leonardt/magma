module coreir_term #(
    parameter width = 1
) (
    input [width-1:0] in
);

endmodule

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
    input [3:0] I,
    output [3:0] O,
    input CLK
);
coreir_reg #(
    .clk_posedge(1'b1),
    .init(4'h0),
    .width(4)
) reg_P4_inst0 (
    .clk(CLK),
    .in(I),
    .out(O)
);
coreir_term #(
    .width(4)
) term_inst0 (
    .in(4'h0)
);
coreir_term #(
    .width(4)
) term_inst1 (
    .in(4'h0)
);
endmodule

module Basic (
    input [3:0] I,
    input S,
    output [3:0] O,
    input CLK
);
wire [3:0] Register_inst0_O;
Register Register_inst0 (
    .I(I),
    .O(Register_inst0_O),
    .CLK(CLK)
);
Register Register_inst1 (
    .I(Register_inst0_O),
    .O(O),
    .CLK(CLK)
);
endmodule

