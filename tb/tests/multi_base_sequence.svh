`ifndef __MULTI_BASE_SEQUENCE_SVH__
`define __MULTI_BASE_SEQUENCE_SVH__

class multi_base_sequence #(parameter WIDTH = 4) extends uvm_sequence #(transaction_in#(.WIDTH(WIDTH)));

  randc bit[WIDTH-1:0] A;
  randc bit[WIDTH-1:0] B;
  rand  bit            i_valid;
  
  
  
  `uvm_object_param_utils(multi_base_sequence #(WIDTH))

  function new(string name = "multi_base_sequence #(parameter WIDTH = 4)");
    super.new(name);
  endfunction
  

  virtual task body();
    `uvm_info("multi_base_sequence",  $sformatf("send transaction to sequencer"), UVM_LOW)
    `uvm_do_with(req, {A == local::A; B == local::B; i_valid == local::i_valid;})
    
  endtask

  
endclass

`endif
