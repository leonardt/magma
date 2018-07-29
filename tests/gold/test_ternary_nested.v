module test_ternary_nested (input [3:0] I, input [1:0] S, output  O);
wire  inst0_O;
wire  inst1_O;
Mux2 inst0 (.I0(I[1]), .I1(I[2]), .S(S[1]), .O(inst0_O));
Mux2 inst1 (.I0(I[0]), .I1(inst0_O), .S(S[0]), .O(inst1_O));
assign O = inst1_O;
endmodule

