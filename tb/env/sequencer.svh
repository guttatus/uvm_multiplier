`ifndef __SEQUENCER_SVH__
`define __SEQUENCER_SVH__

class sequencer #(parameter WIDTH = 4) extends uvm_sequencer #(transaction_in #(.WIDTH(WIDTH)));
  
  
  `uvm_component_param_utils(sequencer #(WIDTH))

  function new(string name = "sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction

  
endclass

`endif
