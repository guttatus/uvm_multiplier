`ifndef __REF_MODEL_SVH__
`define __REF_MODEL_SVH__

class ref_model #(parameter WIDTH = 4) extends uvm_component;
  
  
  `uvm_component_param_utils(ref_model #(WIDTH))
  
  typedef transaction_in #(.WIDTH(WIDTH)) trans_in;
  typedef transaction_out #(.WIDTH(WIDTH)) trans_out;

  uvm_blocking_get_port #(trans_in) port;
  uvm_analysis_port #(trans_out) ap;

  function new(string name = "ref_model", uvm_component parent);
    super.new(name, parent);
  endfunction
    

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    port = new("port",this);
    ap  = new("ap",this);
  endfunction : build_phase

  virtual task main_phase(uvm_phase phase);
    trans_in tr;
    trans_out new_tr;
    super.main_phase(phase);
    while(1) begin
      port.get(tr);
      new_tr = new("new_tr");
      new_tr.P = tr.A *  tr.B;
      `uvm_info("ref_model", "get one transaction, copy and print it:", UVM_LOW)
      new_tr.print();
      ap.write(new_tr);
    end
  endtask: main_phase
  
  
endclass

`endif
