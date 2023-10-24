module multi_shifter #(
    parameter WIDTH = 4
) (
    input                    clk,
    input                    rst_n,
    input                    i_valid,
    input                    ready,
    input      [  WIDTH-1:0] A,
    input      [  WIDTH-1:0] B,
    input      [  WIDTH-1:0] cnt,
    output     [2*WIDTH-1:0] AS,
    output     [  WIDTH-1:0] BS
);

  reg [WIDTH-1:0] A_tmp;
  reg [WIDTH-1:0] B_tmp;

  always @(posedge clk or negedge rst_n) begin : A_tmp_gen
    if (!rst_n) begin
      A_tmp <= 0;
      B_tmp <= 0;
    end else begin
      if (ready && i_valid) begin
        A_tmp <= A;
        B_tmp <= B;
      end else begin
        A_tmp <= A_tmp;
        B_tmp <= B_tmp;
      end
    end
  end

  assign AS = A_tmp << cnt;
  assign BS = B_tmp >> cnt;


endmodule
