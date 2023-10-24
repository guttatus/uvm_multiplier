module multi_ctrl #(
    parameter WIDTH = 4
) (
    input                  clk,
    input                  rst_n,
    input                  i_valid,
    input      [WIDTH-1:0] BS,
    output reg [WIDTH-1:0] cnt,
    output reg             ready,
    output reg             o_valid,
    output                 need_add,
    output                 p_init
);


  wire  accept_input;
  assign accept_input = ready && i_valid;

  reg accept_input_p;

  always @(posedge clk or negedge rst_n) begin 
    if (!rst_n) begin
      accept_input_p <= 0;
    end else begin
      accept_input_p <= accept_input;
    end
  end




  always @(posedge clk or negedge rst_n) begin : cnt_gen
    if (!rst_n) begin
      cnt <= 0;
    end else begin
      if ((cnt == WIDTH - 1) || ready) begin
        cnt <= 0;
      end else begin
        cnt <= cnt + 1;
      end
    end
  end

  always @(posedge clk or negedge rst_n) begin : o_valid_gen
    if (!rst_n) begin
      o_valid <= 1'b0;
    end else begin
      if(WIDTH == 1 && !accept_input_p) begin
        o_valid <= 1'b0;
      end else if (cnt == WIDTH - 1) begin
        o_valid <= 1'b1;
      end else begin
        o_valid <= 1'b0;
      end
    end
  end


  always @(posedge clk or negedge rst_n) begin : ready_gen
    if (!rst_n) begin
      ready <= 1'b1;
    end else begin
      if (WIDTH == 1) begin 
        ready <= 1'b1;
      end else if (accept_input) begin
        ready <= 1'b0;
      end else if (cnt == WIDTH - 2) begin
        ready <= 1'b1;
      end else begin
        ready <= ready;
      end
    end
  end

  assign need_add = (BS[0] == 1'b1) ? 1'b1 : 1'b0;
  assign p_init   = (cnt == 0) ? 1'b1 : 1'b0;

endmodule
