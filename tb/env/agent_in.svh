`ifndef __AGENT_IN_SVH__
`define __AGENT_IN_SVH__

`include "driver_dut.svh"
`include "monitor_in.svh"
`include "sequencer.svh"

class agent_in #(parameter WIDTH = 4) extends  uvm_agent;
  typedef sequencer #(.WIDTH(WIDTH)) sqr_t;
  typedef driver_dut #(.WIDTH(WIDTH)) drv_t;
  typedef monitor_in #(.WIDTH(WIDTH)) mon_t;

  sqr_t sqr;
  drv_t drv;
  mon_t mon;

  typedef transaction_in #(.WIDTH(WIDTH)) trans_in;

  uvm_analysis_port #(trans_in) ap;

   function new(string name, uvm_component parent);
       super.new(name, parent);
    endfunction 
    
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(is_active == UVM_ACTIVE) begin
        sqr = sqr_t::type_id::create("sqr",this);
        drv = drv_t::type_id::create("drv",this);
      end
      mon = mon_t::type_id::create("mon",this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if(is_active == UVM_ACTIVE) begin
        drv.seq_item_port.connect(sqr.seq_item_export);
      end

      ap = mon.ap;
    endfunction
 
    `uvm_component_param_utils(agent_in #(WIDTH))
endclass


`endif
