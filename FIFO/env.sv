class environment;
  generator gen;
  driver dri;
  monitor mon;
  scoreboard sco;
  mailbox #(transaction) gen_dri_mbx;
  mailbox #(transaction) mon_sco_mbx;
  event next_test;
  virtual FIFO_Intf intf;
  
  function new(virtual FIFO_Intf intf);
    gen_dri_mbx = new();
    mon_sco_mbx = new();
    gen = new(gen_dri_mbx);
    dri = new(gen_dri_mbx);
    mon = new(mon_sco_mbx);
    sco = new(mon_sco_mbx);
    this.intf = intf;
    dri.drv_dut_if = this.intf;
    mon.dut_mon_if = this.intf;
    gen.next = next_test;
    sco.next = next_test;
  endfunction
  
  task pre_test();
    dri.reset();
  endtask: pre_test
  
  task test();
    fork
      gen.run();
      dri.run();
      mon.run();
      sco.run();
    join_any
  endtask: test
  
  task post_test();
    wait(gen.done.triggered);
    $display("---------------------------------------------");
    $display("[Time: %0t] Error Count: %0d", $time, sco.err);
    $display("---------------------------------------------");
    $finish();
  endtask: post_test
    
  
  task run();
    pre_test();
    test();
    post_test();
  endtask: run
  
endclass: environment
