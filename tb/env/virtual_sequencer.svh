`ifndef __VIRTUAL_SEQUENCE_SVH__
`define __VIRTUAL_SEQUENCE_SVH__

`include "sequencer.svh"

class virtual_sequencer #(parameter WIDTH = 4)  extends uvm_sequencer;
  
  typedef sequencer #(.WIDTH(WIDTH)) sqr_t;
  sqr_t p_dut_sqr;
  
  `uvm_component_param_utils(virtual_sequencer #(WIDTH))

  function new(string name = "virtual_sequencer #(parameter WIDTH = 4) ", uvm_component parent);
    super.new(name, parent);
  endfunction

  
endclass

`endif
