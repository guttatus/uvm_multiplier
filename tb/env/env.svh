`ifndef __ENV_SVH__
`define __ENV_SVH__

`include "agent_in.svh"
`include "agent_out.svh"
`include "ref_model.svh"
`include "scoreboard.svh"

class multi_env #(parameter WIDTH = 4) extends uvm_env;
  
  `uvm_component_param_utils(multi_env #(WIDTH))
  typedef agent_in  #(.WIDTH(WIDTH)) agent_in_t;
  typedef agent_out #(.WIDTH(WIDTH)) agent_out_t;
  typedef ref_model #(.WIDTH(WIDTH)) model_t;
  typedef scoreboard #(.WIDTH(WIDTH)) scb_t;
  typedef transaction_in #(.WIDTH(WIDTH)) trans_in;
  typedef transaction_out #(.WIDTH(WIDTH)) trans_out;

  agent_in_t agt_in;
  agent_out_t agt_out;
  model_t mdl;
  scb_t scb;

  uvm_tlm_analysis_fifo #(trans_out) agt_scb_fifo;
  uvm_tlm_analysis_fifo #(trans_in) agt_mdl_fifo;
  uvm_tlm_analysis_fifo #(trans_out) mdl_scb_fifo;
  

  function new(string name = "multi_env #(parameter WIDTH = 4) ", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt_in = agent_in_t::type_id::create("agt_in",this);
    agt_out = agent_out_t::type_id::create("agt_out",this);
    agt_in.is_active = UVM_ACTIVE;
    agt_out.is_active = UVM_PASSIVE;
    mdl = model_t::type_id::create("mdl",this);
    scb = scb_t::type_id::create("scb",this);
    agt_scb_fifo = new("agt_scb_fifo", this);
    agt_mdl_fifo = new("agt_mdl_fifo", this);
    mdl_scb_fifo = new("mdl_scb_fifo", this);
    
  endfunction : build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agt_in.ap.connect(agt_mdl_fifo.analysis_export);
    mdl.port.connect(agt_mdl_fifo.blocking_get_export);
    mdl.ap.connect(mdl_scb_fifo.analysis_export);
    scb.exp_port.connect(mdl_scb_fifo.blocking_get_export);
    agt_out.ap.connect(agt_scb_fifo.analysis_export);
    scb.act_port.connect(agt_scb_fifo.blocking_get_export);
  endfunction : connect_phase

endclass

`endif
