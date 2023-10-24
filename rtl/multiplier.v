module multiplier #(
    parameter WIDTH = 4
) (
    input                    clk,
    input                    rst_n,
    input      [  WIDTH-1:0] A,
    input      [  WIDTH-1:0] B,
    input                    i_valid,
    output reg               ready,
    output reg               o_valid,
    output reg [2*WIDTH-1:0] P
);
  wire [2*WIDTH-1:0] AS;
  wire [  WIDTH-1:0] BS;
  wire [  WIDTH-1:0] cnt;
  wire               need_add;
  wire               p_init;

  multi_ctrl #(
      .WIDTH(WIDTH)
  ) multi_ctrl_inst (
      .clk     (clk),
      .rst_n   (rst_n),
      .i_valid (i_valid),
      .BS      (BS),
      .cnt     (cnt),
      .ready   (ready),
      .o_valid (o_valid),
      .need_add(need_add),
      .p_init  (p_init)
  );

  multi_shifter #(
      .WIDTH(WIDTH)
  ) multi_shifter_inst (
      .clk    (clk),
      .rst_n  (rst_n),
      .i_valid(i_valid),
      .ready  (ready),
      .A      (A),
      .B      (B),
      .cnt    (cnt),
      .AS     (AS),
      .BS     (BS)
  );

  multi_alu #(
      .WIDTH(WIDTH)
  ) multi_alu_inst (
      .clk     (clk),
      .rst_n   (rst_n),
      .need_add(need_add),
      .p_init  (p_init),
      .AS      (AS),
      .P       (P)
  );


endmodule
