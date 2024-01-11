`include "transaction.sv"

class generator;
  transaction tr_obj;
  mailbox #(transaction) gen_mbx;
  int count = 0;
  event next, done;
  
  // custom constructor with mailbox 
  function new(mailbox #(transaction) gen_mbx);
    this.gen_mbx = gen_mbx;
    tr_obj = new();
  endfunction
  
  // task to randomize and generate stimuli for given count
  task run();
    for(int i=0; i<count; i++) begin
      tr_obj.randomize();
      gen_mbx.put(tr_obj);
      $display("[Time: %0t] [Generator] Operation: %0d, Iteration: %0d", $time,  tr_obj.operation, i);
      @(next);
    end
    -> done;
  endtask: run
endclass: generator
