module COND1_compile_guard(	// <stdin>:1:1
  input port_0, CLK);

  `ifdef COND1	// <stdin>:2:5
    reg Register_inst0;	// <stdin>:3:14

    always_ff @(posedge CLK)	// <stdin>:4:9
      Register_inst0 <= port_0;	// <stdin>:5:13
    initial	// <stdin>:8:9
      Register_inst0 = 1'h0;	// <stdin>:7:14, :9:13
  `endif
endmodule

module COND2_compile_guard(	// <stdin>:14:1
  input port_0, CLK);

  `ifndef COND2	// <stdin>:15:5
    reg Register_inst0;	// <stdin>:17:14

    always_ff @(posedge CLK)	// <stdin>:18:9
      Register_inst0 <= port_0;	// <stdin>:19:13
    initial	// <stdin>:22:9
      Register_inst0 = 1'h0;	// <stdin>:21:14, :23:13
  `endif
endmodule

module simple_compile_guard(	// <stdin>:28:1
  input  I, CLK,
  output O);

  `ifdef COND1	// <stdin>:29:5
    COND1_compile_guard COND1_compile_guard (	// <stdin>:30:9
      .port_0 (I),
      .CLK    (CLK)
    );
  `endif
  `ifndef COND2	// <stdin>:32:5
    COND2_compile_guard COND2_compile_guard (	// <stdin>:34:9
      .port_0 (I),
      .CLK    (CLK)
    );
  `endif
  assign O = I;	// <stdin>:36:5
endmodule

