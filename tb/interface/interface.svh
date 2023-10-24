`ifndef __INTERFACE_SHV__
`define __INTERFACE_SHV__

interface multi_if #(
    parameter WIDTH = 4
) (
    input clk,
    input rst_n
);
  logic [  WIDTH-1:0] A;
  logic [  WIDTH-1:0] B;
  logic               i_valid;
  logic               ready;
  logic [2*WIDTH-1:0] P;
  logic               o_valid;

endinterface

interface multi_if_out #(
    parameter WIDTH = 4
) (
    input clk,
    input rst_n
);
  logic               ready;
  logic [2*WIDTH-1:0] P;
  logic               o_valid;

endinterface

`endif
