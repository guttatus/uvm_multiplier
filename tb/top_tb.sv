// `include "uvm_macros.svh"
// import uvm_pkg::*;


`include "uvm_macros.svh"
import  uvm_pkg::*;

`include "interface.svh"
`include "test_top.svh"

module top_tb ();

  localparam WIDTH = 5;
  reg clk;
  reg rst_n;

  initial begin : clk_rst_init
    clk   = 0;
    rst_n = 0;
    #15 rst_n = 1;
  end

  always #2 clk = ~clk;

  multi_if #(.WIDTH(WIDTH)) io_if(clk, rst_n);
  multi_if_out #(.WIDTH(WIDTH)) o_if(clk,rst_n);



  multiplier #(
      .WIDTH(WIDTH)
  ) multiplier_inst (
      .clk    (clk),
      .rst_n  (rst_n),
      .A      (io_if.A),
      .B      (io_if.B),
      .i_valid(io_if.i_valid),
      .ready  (io_if.ready),
      .o_valid(io_if.o_valid),
      .P      (io_if.P)
  );

  assign o_if.ready   = io_if.ready;
  assign o_if.P       = io_if.P;
  assign o_if.o_valid = io_if.o_valid;


  typedef order_data_multi_test #(WIDTH) odmt;
  typedef random_data_multi_test #(WIDTH) rdmt;
  typedef input_always_valid_test #(WIDTH) iavt;

  initial begin : connect_if
    $timeformat(-9, 2, "ns", 10);      
    uvm_config_db #(virtual multi_if #(.WIDTH(WIDTH)))::set(null,"uvm_test_top.env.agt_in.drv","vif", io_if);
    uvm_config_db #(virtual multi_if #(.WIDTH(WIDTH)))::set(null,"uvm_test_top.env.agt_in.mon","vif", io_if);
    uvm_config_db #(virtual multi_if_out #(.WIDTH(WIDTH)))::set(null,"uvm_test_top.env.agt_out.mon","vif", o_if);
    run_test();
  end

  initial begin 
    string testname;
      if($value$plusargs("TESTNAME=%s", testname)) begin
          $fsdbDumpfile({testname, "_sim_dir/", testname, ".fsdb"});
      end else begin
          $fsdbDumpfile("top_tb.fsdb");
      end
      $fsdbDumpvars(0, top_tb);
  end

endmodule

