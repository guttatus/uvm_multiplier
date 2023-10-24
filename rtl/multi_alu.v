module multi_alu #(
    parameter WIDTH = 4
) (
    input                    clk,
    input                    rst_n,
    input                    need_add,
    input                    p_init,
    input      [2*WIDTH-1:0] AS,
    output reg [2*WIDTH-1:0] P
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      P <= 0;
    end else begin
      if (p_init) begin
        P <= (need_add == 1'b1) ? AS : 0;
      end else begin
        P <= (need_add == 1'b1) ? (AS + P) : P;
      end
    end
  end



endmodule
