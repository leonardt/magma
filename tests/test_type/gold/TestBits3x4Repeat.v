module TestRepeat (
    input [2:0] I,
    output [11:0] O
);
assign O = {I[2:0],I[2:0],I[2:0],I[2:0]};
endmodule

