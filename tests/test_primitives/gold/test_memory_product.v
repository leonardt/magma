module mantle_wire__typeBitIn5 (
    output [4:0] in,
    input [4:0] out
);
assign in = out;
endmodule

module coreir_mem #(
    parameter has_init = 1'b0,
    parameter sync_read = 1'b0,
    parameter depth = 1,
    parameter width = 1,
    parameter [(width * depth) - 1:0] init = 0
) (
    input clk,
    input [width-1:0] wdata,
    input [$clog2(depth)-1:0] waddr,
    input wen,
    output [width-1:0] rdata,
    input [$clog2(depth)-1:0] raddr
);
  reg [width-1:0] data [depth-1:0];
  generate if (has_init) begin
    genvar j;
    for (j = 0; j < depth; j = j + 1) begin
      initial begin
        data[j] = init[(j+1)*width-1:j*width];
      end
    end
  end
  endgenerate
  always @(posedge clk) begin
    if (wen) begin
      data[waddr] <= wdata;
    end
  end
  generate if (sync_read) begin
  reg [width-1:0] rdata_reg;
  always @(posedge clk) begin
    rdata_reg <= data[raddr];
  end
  assign rdata = rdata_reg;
  end else begin
  assign rdata = data[raddr];
  end
  endgenerate

endmodule

module Memory (
    input CLK,
    input [1:0] RADDR,
    output RDATA_X,
    output [4:0] RDATA_Y,
    input [1:0] WADDR,
    input WDATA_X,
    input [4:0] WDATA_Y,
    input WE
);
wire [5:0] coreir_mem4x6_inst0_rdata;
wire [4:0] self_RDATA_Y_in;
wire [5:0] coreir_mem4x6_inst0_wdata;
assign coreir_mem4x6_inst0_wdata = {WDATA_Y,WDATA_X};
coreir_mem #(
    .depth(4),
    .has_init(1'b0),
    .sync_read(1'b0),
    .width(6)
) coreir_mem4x6_inst0 (
    .clk(CLK),
    .wdata(coreir_mem4x6_inst0_wdata),
    .waddr(WADDR),
    .wen(WE),
    .rdata(coreir_mem4x6_inst0_rdata),
    .raddr(RADDR)
);
mantle_wire__typeBitIn5 self_RDATA_Y (
    .in(self_RDATA_Y_in),
    .out(coreir_mem4x6_inst0_rdata[5:1])
);
assign RDATA_X = coreir_mem4x6_inst0_rdata[0];
assign RDATA_Y = self_RDATA_Y_in;
endmodule

module test_memory_product (
    input clk,
    input [1:0] raddr,
    output rdata_X,
    output [4:0] rdata_Y,
    input [1:0] waddr,
    input wdata_X,
    input [4:0] wdata_Y,
    input wen
);
wire Memory_inst0_RDATA_X;
wire [4:0] Memory_inst0_RDATA_Y;
Memory Memory_inst0 (
    .CLK(clk),
    .RADDR(raddr),
    .RDATA_X(Memory_inst0_RDATA_X),
    .RDATA_Y(Memory_inst0_RDATA_Y),
    .WADDR(waddr),
    .WDATA_X(wdata_X),
    .WDATA_Y(wdata_Y),
    .WE(wen)
);
assign rdata_X = Memory_inst0_RDATA_X;
assign rdata_Y = Memory_inst0_RDATA_Y;
endmodule

