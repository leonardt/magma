module LUT(	// <stdin>:1:1
  input  [1:0]                                         I,
  output struct packed {logic [7:0] x; logic y; }[1:0] O);

wire [3:0] _T = {{1'h0}, {1'h1}, {1'h1}, {1'h1}};	// <stdin>:2:10, :3:10, :4:10
wire [3:0] _T_0 = {{1'h1}, {1'h1}, {1'h1}, {1'h1}};	// <stdin>:3:10, :6:10
wire [3:0] _T_1 = {{1'h1}, {1'h0}, {1'h1}, {1'h1}};	// <stdin>:2:10, :3:10, :8:10
wire [3:0] _T_2 = {{1'h1}, {1'h1}, {1'h1}, {1'h1}};	// <stdin>:3:10, :10:10
wire [3:0] _T_3 = {{1'h1}, {1'h0}, {1'h0}, {1'h0}};	// <stdin>:2:10, :3:10, :12:11
wire [3:0] _T_4 = {{1'h0}, {1'h0}, {1'h1}, {1'h0}};	// <stdin>:2:10, :3:10, :14:11
wire [3:0] _T_5 = {{1'h0}, {1'h1}, {1'h1}, {1'h0}};	// <stdin>:2:10, :3:10, :16:11
wire [3:0] _T_6 = {{1'h0}, {1'h0}, {1'h0}, {1'h0}};	// <stdin>:2:10, :18:11
wire [3:0] _T_7 = {{1'h1}, {1'h1}, {1'h1}, {1'h0}};	// <stdin>:2:10, :3:10, :21:11
wire struct packed {logic [7:0] x; logic y; } _T_8 = '{x: {_T_6[I], _T_5[I], _T_4[I], _T_3[I], _T_2[I], _T_1[I], _T_0[I], _T[I]}, y: _T_7[I]};	// <stdin>:5:10, :7:10, :9:10, :11:10, :13:11, :15:11, :17:11, :19:11, :20:11, :22:11, :23:11
wire [3:0] _T_9 = {{1'h0}, {1'h1}, {1'h1}, {1'h1}};	// <stdin>:2:10, :3:10, :24:11
wire [3:0] _T_10 = {{1'h1}, {1'h0}, {1'h1}, {1'h1}};	// <stdin>:2:10, :3:10, :26:11
wire [3:0] _T_11 = {{1'h0}, {1'h0}, {1'h0}, {1'h0}};	// <stdin>:2:10, :28:11
wire [3:0] _T_12 = {{1'h0}, {1'h1}, {1'h0}, {1'h1}};	// <stdin>:2:10, :3:10, :30:11
wire [3:0] _T_13 = {{1'h1}, {1'h0}, {1'h0}, {1'h0}};	// <stdin>:2:10, :3:10, :32:11
wire [3:0] _T_14 = {{1'h0}, {1'h0}, {1'h0}, {1'h0}};	// <stdin>:2:10, :34:11
wire [3:0] _T_15 = {{1'h0}, {1'h1}, {1'h1}, {1'h0}};	// <stdin>:2:10, :3:10, :36:11
wire [3:0] _T_16 = {{1'h0}, {1'h1}, {1'h1}, {1'h1}};	// <stdin>:2:10, :3:10, :38:11
wire [3:0] _T_17 = {{1'h1}, {1'h1}, {1'h0}, {1'h0}};	// <stdin>:2:10, :3:10, :41:11
wire struct packed {logic [7:0] x; logic y; } _T_18 = '{x: {_T_16[I], _T_15[I], _T_14[I], _T_13[I], _T_12[I], _T_11[I], _T_10[I], _T_9[I]}, y:
                _T_17[I]};	// <stdin>:25:11, :27:11, :29:11, :31:11, :33:11, :35:11, :37:11, :39:11, :40:11, :42:11, :43:11
  assign O = {{_T_18}, {_T_8}};	// <stdin>:44:11, :45:5
endmodule

module complex_lut(	// <stdin>:47:1
  input  [1:0]                                         a,
  output struct packed {logic [7:0] x; logic y; }[1:0] y);

  LUT LUT_inst0 (	// <stdin>:48:10
    .I (a),
    .O (y)
  );
endmodule

