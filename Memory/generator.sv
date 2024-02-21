// generator class which will generate the transaction object

class generator;
  // declare transaction obj
  transaction tr_obj;
  // mailbox to synchronize data transfer and holds transaction object
  mailbox#(transaction) gen_mbx;
  int count = 0;
  // events to trigger random object generation and finish generation
  event next, done;

  // constructor to create the required objects in heirarchy
  function new(mailbox#(transaction) gen_mbx);
    this.gen_mbx = gen_mbx;
    tr_obj = new();
  endfunction:new

  // task to generate stimuli based on count
  task run();
    for(int i=0; i<count; i++)
    begin
      // randomize object and put in mailbox
      tr_obj.randomize();
      gen_mbx.put(tr_obj);
      if(tr_obj.writeEnable == 1'b1)
        $display("[Time: %0t] [Generator]: Data randomized. Read?: %0b, \
Write?: %0b, Location: %0b, Data: %0d", $time, tr_obj.readEnable,
                tr_obj.writeEnable, tr_obj.rwAddr, tr_obj.writeData_in);
      if(tr_obj.readEnable == 1'b1)
        $display("[Time: %0t] [Generator]: Data randomized. Read?: %0b, \
Write?: %0b, Location: %0b", $time, tr_obj.readEnable,
                tr_obj.writeEnable, tr_obj.rwAddr);
      // wait for object to be taken by driver and proceed
      @(next);
    end
    // mark done when all stimuli generation is complete
    ->done;
  endtask: run

endclass: generator
