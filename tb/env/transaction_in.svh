`ifndef __TRANSACTION_IN__
`define __TRANSACTION_IN__

class transaction_in #(parameter WIDTH = 4) extends uvm_sequence_item;

  randc bit[WIDTH-1:0] A;
  randc bit[WIDTH-1:0] B;
  rand  bit            i_valid;

  // localparam MAX = (1<<WIDTH)-1;

  // constraint data_cstr {
  //   A inside {[0:MAX]};
  //   B inside {[0:MAX]};
  // }
  
  `uvm_object_param_utils_begin(transaction_in #(WIDTH))
      `uvm_field_int(A,UVM_ALL_ON)
      `uvm_field_int(B,UVM_ALL_ON)
      `uvm_field_int(i_valid,UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "transaction_in #(WIDTH)");
    super.new(name);
  endfunction
endclass

`endif
