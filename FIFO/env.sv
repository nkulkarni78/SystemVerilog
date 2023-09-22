//This is environment class which will contain all objects 
//of SV testbench for FIFO design.

class env;
  generator gen;
  driver dr;

  monitor mon;
  scoreboard sco;

  //mailbox to retrieve data from generator to driver class
  //to drive stimulus into DUT once generator randomizes
  mailbox #(transaction) gdmbx;
  mailbox #(transaction) msmbx;

  event nextgs;

  virtual ifc fifo_itfc;

  //function to create objects of all the class instance in
  //testbench environment
  function new(virtual ifc fifo_itfc);
    gdmbx = new();
    gen = new(gdmbx);
    dr = new(gdmbx);

    msmbx = new();
    mon = new(msmbx);
    sco = new(msmbx);

    this.fifo_itfc =  fifo_itfc;

    dr.fifo_itfc = this.fifo_itfc;
    mon.fifo_itfc = this.fifo_itfc;

    gen.next = nextgs;
    sco.next = nextgs;
  endfunction

  //reset DUT using pre_test task
  task pre_test();
    dr.reset();
  endtask

  //start the test
  task test();
    fork
      gen.run();
      dr.run();
      mon.run();
      sco.run();
    join_any
  endtask

  //end the test
  task post_test();
    wait(gen.done.triggered);
    $finish();
  endtask

  //Start the run
  task run();
    pre_test();
    test();
    post_test();
  endtask
endclass
