`ifndef __MONITOR_OUT_SVH__
`define __MONITOR_OUT_SVH__

`include "transaction_out.svh"

class monitor_out #(parameter WIDTH = 4) extends uvm_monitor;
  
  virtual multi_if_out #(.WIDTH(WIDTH)) vif;

  typedef transaction_out#(.WIDTH(WIDTH)) trans_out;

  uvm_analysis_port #(trans_out) ap;
  
  `uvm_component_param_utils(monitor_out #(WIDTH))

  function new(string name = "monitor_out #(WIDTH)", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual multi_if_out #(.WIDTH(WIDTH)))::get(this,"","vif",vif)) begin
      `uvm_fatal("monitor_out", "virtual interface must be set for vif!!")
    end
   ap = new("ap",this);
  endfunction
  
  virtual task main_phase(uvm_phase phase);
    trans_out tr;
    while(1) begin
      tr = new("tr");
      collect_one_pkt(tr);
      ap.write(tr);
    end
  endtask: main_phase

  task collect_one_pkt(trans_out tr);
    @(posedge vif.clk iff(vif.o_valid));
    `uvm_info("monitor_out", "begin to collect one pkt", UVM_HIGH);
    tr.P = vif.P;
    `uvm_info("monitor_out", $sformatf("collect one pkt: \n%s", tr.sprint()), UVM_LOW);
  endtask
endclass

`endif
