`ifndef __RANDOM_DATA_MULTI_TEST_SVH__
`define __RANDOM_DATA_MULTI_TEST_SVH__

`include "multi_base_sequence.svh"

class random_data_multi_seq #(
    parameter WIDTH = 4
) extends uvm_sequence;


  localparam MAX = (1<<WIDTH);

  `uvm_object_param_utils(random_data_multi_seq#(WIDTH))
  `uvm_declare_p_sequencer(virtual_sequencer#(.WIDTH(WIDTH)))

  function new(string name = "random_data_multi_seq");
    super.new(name);
  endfunction

  virtual task body();
    multi_base_sequence #(.WIDTH(WIDTH)) dut_seq;

    if (starting_phase != null) begin
      starting_phase.raise_objection(this);
    end

    for(int i = 0; i < MAX*WIDTH; i++) begin
      `uvm_do_on(dut_seq, p_sequencer.p_dut_sqr)
    end

    #100;

    if (starting_phase != null) begin
      starting_phase.drop_objection(this);
    end

  endtask
endclass

class random_data_multi_test #(
    parameter WIDTH = 4
) extends base_test #(
    .WIDTH(WIDTH)
);
  // `uvm_component_param_utils(random_data_multi_test #(WIDTH))
  typedef uvm_component_registry#(random_data_multi_test#(WIDTH), "random_data_multi_test") type_id;

  function new(string name = "random_data_multi_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    /* 1. use default_sequence */
    uvm_config_db#(uvm_object_wrapper)::set(this, "v_sqr.main_phase", "default_sequence",
                                            random_data_multi_seq#(.WIDTH(WIDTH))::type_id::get());

  endfunction

endclass

`endif
