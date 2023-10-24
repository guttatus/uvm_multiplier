`ifndef __SCOREBOARD_SVH__
`define __SCOREBOARD_SVH__

class scoreboard #(parameter WIDTH = 4) extends uvm_scoreboard;
  
  
  typedef transaction_out #(.WIDTH(WIDTH)) trans_out;

  `uvm_component_param_utils(scoreboard #(WIDTH))

  uvm_blocking_get_port #(trans_out) exp_port;
  uvm_blocking_get_port #(trans_out) act_port;
  trans_out expect_quene[$];


  function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    exp_port = new("exp_port",this);
    act_port = new("act_port",this);
  endfunction : build_phase

  virtual task main_phase(uvm_phase phase);
    trans_out get_export, get_actual, tmp_tran;
    bit result;

    super.main_phase(phase);
    fork
      while (1) begin
        exp_port.get(get_export);
        expect_quene.push_back(get_export);
      end

      while (1) begin
        act_port.get(get_actual);
        if(expect_quene.size() > 0) begin
          tmp_tran = expect_quene.pop_front();
          result = get_actual.compare(tmp_tran);
          if(result) begin
            `uvm_info("scoreboard", "Compare SUCCESSFULLY", UVM_LOW)
          end else begin
            `uvm_error("scoreboard", "Compare FALIED")
            $display("the expect pkt is");
            tmp_tran.print();
            $display("the actual  pkt is");
            get_actual.print();
          end
        end else begin
          `uvm_error("my_scoreboard", "Received from DUT, while Expect Queue is empty");
          $display("the unexpected pkt is");
          get_actual.print();
        end
      end
    join
    
  endtask: main_phase

  
endclass
    
`endif
