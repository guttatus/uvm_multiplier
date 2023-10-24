`ifndef __DRIVER_DUT_SVH__
`define __DRIVER_DUT_SVH__

`include "transaction_in.svh"

class driver_dut #(
    parameter WIDTH = 4
) extends uvm_driver #(transaction_in #(
    .WIDTH(WIDTH)
));

  virtual multi_if #(.WIDTH(WIDTH)) vif;
  typedef transaction_in#(.WIDTH(WIDTH)) trans_in;

  `uvm_component_param_utils(driver_dut#(WIDTH))

  function new(string name = "driver_dut #(WIDTH)", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual multi_if #(.WIDTH(WIDTH)))::get(this, "", "vif", vif)) begin
      `uvm_fatal("driver_dut", "virtual interface must be set for vif")
    end
  endfunction

  virtual task main_phase(uvm_phase phase);
    vif.A <= 0;
    vif.B <= 0;
    vif.i_valid <= 0;
    while (!vif.rst_n) @(posedge vif.clk);
    while (1) begin
      seq_item_port.get_next_item(req);
      drive_on_pkt(req);
      seq_item_port.item_done();
    end
  endtask

  task drive_on_pkt(trans_in tr);
    `uvm_info("driver_dut", "begin to drive one pkt", UVM_HIGH);
    vif.A <= tr.A;
    vif.B <= tr.B;
    vif.i_valid <= tr.i_valid;
    @(posedge vif.clk);
    `uvm_info("driver_dut", "end driver one pkt", UVM_HIGH);
  endtask
endclass


`endif
