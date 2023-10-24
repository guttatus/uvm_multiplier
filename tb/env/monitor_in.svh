`ifndef __MONITOR_IN_SVH__
`define __MONITOR_IN_SVH__

`include "transaction_in.svh"

class monitor_in #(parameter WIDTH = 4) extends uvm_monitor;
  
  virtual multi_if #(.WIDTH(WIDTH)) vif;
  typedef transaction_in #(.WIDTH(WIDTH)) trans_in;

  uvm_analysis_port #(trans_in) ap;
  
  `uvm_component_param_utils(monitor_in #(WIDTH))

  function new(string name = "monitor_in #(WIDTH)", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual multi_if #(.WIDTH(WIDTH)))::get(this,"","vif",vif)) begin
      `uvm_fatal("monitor_in", "virtual interface must be set for vif!!")
    end
   ap = new("ap",this);
  endfunction
  
  virtual task main_phase(uvm_phase phase);
    trans_in tr;
    while(1) begin
      tr = new("tr");
      collect_one_pkt(tr);
      ap.write(tr);
    end
  endtask: main_phase

  task collect_one_pkt(trans_in tr);
    @(posedge vif.clk iff(vif.i_valid && vif.ready));
    `uvm_info("monitor_in", "begin to collect one pkt", UVM_HIGH);
    tr.A = vif.A;
    tr.B = vif.B;
    `uvm_info("monitor_in", $sformatf("collect one pkt: \n%s", tr.sprint()), UVM_LOW);
  endtask
endclass

`endif
