`ifndef __AGENT_OUT_SVH__
`define __AGENT_OUT_SVH__

`include "monitor_out.svh"

class agent_out #(parameter WIDTH = 4) extends  uvm_agent;
  typedef monitor_out #(.WIDTH(WIDTH)) mon_t;

  mon_t mon;

  typedef transaction_out #(.WIDTH(WIDTH)) trans_out;

  uvm_analysis_port #(trans_out) ap;

   function new(string name, uvm_component parent);
       super.new(name, parent);
    endfunction 
    
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      mon = mon_t::type_id::create("mon",this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      ap = mon.ap;
    endfunction
 
    `uvm_component_param_utils(agent_out #(WIDTH))
endclass


`endif
