`ifndef __TRANSACTION_OUT__
`define __TRANSACTION_OUT__

class transaction_out #(parameter WIDTH = 4) extends uvm_sequence_item;

  randc bit[2*WIDTH-1:0] P;

  localparam MAX = (1<<(2*WIDTH))-1;

  constraint data_cstr {
    P inside {[0:MAX]};
  }
  
  `uvm_object_param_utils_begin(transaction_out #(WIDTH))
      `uvm_field_int(P,UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "transaction_out #(WIDTH)");
    super.new(name);
  endfunction
endclass

  
`endif
