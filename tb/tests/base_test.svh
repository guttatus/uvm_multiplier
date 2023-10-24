`ifndef __BASE_TEST_SVH__
`define __BASE_TEST_SVH__

`include "env.svh"
`include "virtual_sequencer.svh"

class base_test #(parameter WIDTH = 4) extends uvm_test;
    typedef multi_env #(.WIDTH(WIDTH)) env_t;
    typedef virtual_sequencer #(.WIDTH(WIDTH)) v_sqr_t;
    env_t env;
    v_sqr_t v_sqr;

    `uvm_component_param_utils(base_test #(WIDTH))
    function new(string name = "base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = env_t::type_id::create("env", this);
      v_sqr = v_sqr_t::type_id::create("v_sqr", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      v_sqr.p_dut_sqr = env.agt_in.sqr;
      if(get_report_verbosity_level() >= UVM_HIGH ) begin 
          uvm_top.print_topology();
      end
    endfunction

    virtual function void report_phase(uvm_phase phase);
      uvm_report_server server;
      integer fid;
      int err_num;
      string testname;
      $value$plusargs("TESTNAME=%s", testname);
      super.report_phase(phase);

      server = get_report_server();
      err_num =  server.get_severity_count(UVM_WARNING) + server.get_severity_count(UVM_ERROR) + server.get_severity_count(UVM_FATAL);

      $system("date +[%F/%T] >> result_sim.log");
      fid = $fopen("result_sim.log","a");
      $display("");

      if( err_num != 0 ) begin
          $display("==================================================");
          $display("%s TestCase Failed !!!", testname);
          $display("It has %0d error(s).", err_num);
          $display("!!!!!!!!!!!!!!!!!!");
          $fwrite( fid, $sformatf("TestCase Failed: %s\n\n", testname) );
      end else begin
          $display("==================================================");
          $display("TestCase Passed: %s", testname);
          $display("==================================================");
          $fwrite( fid, $sformatf("TestCase Passed: %s\n\n", testname) );
      end
    endfunction

endclass


`endif 


 
