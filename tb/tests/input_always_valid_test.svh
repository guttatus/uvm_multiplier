`ifndef __INPUT_ALWAYS_VALID_TEST_SVH__
`define __INPUT_ALWAYS_VALID_TEST_SVH__

`include "multi_base_sequence.svh"

class input_always_valid_seq #(
    parameter WIDTH = 4
) extends uvm_sequence;


  `uvm_object_param_utils(input_always_valid_seq#(WIDTH))
  `uvm_declare_p_sequencer(virtual_sequencer#(.WIDTH(WIDTH)))
  localparam MAX = 1 << WIDTH;

  function new(string name = "input_always_valid_seq");
    super.new(name);
  endfunction

  virtual task body();
    multi_base_sequence #(.WIDTH(WIDTH)) dut_seq;

    if (starting_phase != null) begin
      starting_phase.raise_objection(this);
    end


    for(int i = 0; i < MAX*WIDTH; i++) begin
      `uvm_do_on_with(dut_seq, p_sequencer.p_dut_sqr,{i_valid == 1;})
    end
    #100;

    if (starting_phase != null) begin
      starting_phase.drop_objection(this);
    end

  endtask
endclass

class input_always_valid_test #(
    parameter WIDTH = 4
) extends base_test #(
    .WIDTH(WIDTH)
);
  // `uvm_component_param_utils(input_always_valid_test #(WIDTH))
  typedef uvm_component_registry#(input_always_valid_test#(WIDTH), "input_always_valid_test") type_id;

  function new(string name = "input_always_valid_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    /* 1. use default_sequence */
    uvm_config_db#(uvm_object_wrapper)::set(this, "v_sqr.main_phase", "default_sequence",
                                            input_always_valid_seq#(.WIDTH(WIDTH))::type_id::get());

  endfunction

endclass

`endif
