// environment class to instantiate and connect components of TB

class env;
  generator gen_obj;
  driver drv_obj;
  monitor mon_obj;
  scoreboard sco_obj;
  event next, done;
  virtual interface mem_intf mem_intf_inst;
  mailbox #(transaction) gen_drv_mbx;
  mailbox #(transaction) mon_sco_mbx;

  function new(virtual interface mem_intf mem_intf_inst);
    gen_drv_mbx = new();
    mon_sco_mbx = new();
    gen_obj = new(gen_drv_mbx);
    drv_obj = new(gen_drv_mbx);
    mon_obj = new(mon_sco_mbx);
    sco_obj = new(mon_sco_mbx);
    this.mem_intf_inst = mem_intf_inst;
    drv_obj.drv_mem_intf = this.mem_intf_inst;
    mon_obj.mon_mem_intf = this.mem_intf_inst;
    gen_obj.next = this.next;
    this.done = gen_obj.done;
    sco_obj.next = this.next;
  endfunction: new

  task test();
    fork
      gen_obj.run();
      drv_obj.run();
      mon_obj.run();
      sco_obj.run();
    join_any
  endtask: test

  task run();
    $display("[ENV]: TEST STARTED....");
    test();
    wait(done.triggered);
    $display("[ENV]: Finalising Results...");
    $display("---------------------------------------------------------------");
    $display("Total Error: %0d", sco_obj.error);
    $display("---------------------------------------------------------------");
    $finish();
  endtask: run

endclass: env
