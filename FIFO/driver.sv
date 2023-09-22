//Driver class will just receive and drive stimulus on DUT.
//It will handle transaction class object outputs by using
//interface signals. Interface is an abstract class since
//it contains only signals and no definitions for them.

class driver;
  //virtual keyword to say interface is abstract class.
  virtual ifc fifo_itfc;

  //create a mailbox to receive data from generator class
  mailbox #(transaction) mbx;

  //Create transaction class object to collect data
  transaction collect_data;

  //create event to collect packets from generator mailbox
  event next;

  //create an object of mailboxes to receive transaction
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction

  //first step is to reset DUT and then drive stimulus
  task reset();
    fifo_itfc.reset <= 1'b1;
    fifo_itfc.read_en <= 1'b0;
    fifo_itfc.write_en <= 1'b0;
    fifo_itfc.data_in <= 8'd0;
    //fifo_itfc.fifo_full <= 1'b0;
    //fifo_itfc.fifo_empty <= 1'b0;
  endtask

  //start applying random stimulus to DUT
  task run();
    //continue to run this loop always until terminated
    forever
    begin
      //obtain data from current mailbox of driver class
      mbx.get(collect_data);
      collect_data.display("DRV");
      fifo_itfc.read_en <= collect_data.read_en;
      fifo_itfc.write_en <= collect_data.write_en;
      fifo_itfc.data_in <= collect_data.data_in;
      repeat(2) @(posedge fifo_itfc.clock);
      ->next;
    end
  endtask
endclass
