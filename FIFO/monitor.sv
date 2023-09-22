//This is monitor class which will just sample information
//from generator class and provides input to scoreboard.

class monitor;
  //abstract class to use fifo interface connections
  virtual ifc fifo_itfc;
  
  //create a mailbox to handle transaction packets
  mailbox #(transaction) mbx;

  transaction tr;

  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction

  //Obtain stimulus and sample it to mailbox which will be
  //handled by scoreboard.
  task run();
    tr = new();

    forever
    begin
      repeat(2) @(fifo_itfc.clock);
      tr.write_en <= fifo_itfc.write_en;
      tr.read_en <= fifo_itfc.read_en;
      tr.data_in <= fifo_itfc.data_in;
      tr.data_out <= fifo_itfc.data_out;
      tr.fifo_full <= fifo_itfc.fifo_full;
      tr.fifo_empty <= fifo_itfc.fifo_empty;

      mbx.put(tr);

      tr.display("MON");
    end
  endtask
endclass
