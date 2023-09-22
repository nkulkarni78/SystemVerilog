//This is scoreboard class which will compare the results
//and declare if the randomized test is passing or failing.
//we use mailbox to sample the randomized data and apply the
//core logic of the problem to identify the solution from 
//DUT.

class scoreboard;
  mailbox #(transaction) mbx;
  transaction tr;
  event next;

  bit [7:0]din[$];
  bit [7:0] temp;

  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction

  task run();
    forever
    begin
      mbx.get(tr);
      tr.display("SCO");
      if(tr.write_en == 1'b1)
      begin
        din.push_front(tr.data_in);
        $display("[SCO] : Data stored in Queue: %0d",tr.data_in);
      end

      if(tr.read_en == 1'b1)
      begin
        if(tr.fifo_empty == 1'b0)
	begin
	  temp = din.pop_back();
	  if(tr.data_out == temp)
	    $display("DATA MATCH");
	  else
	    $display("DATA MISMATCH");
	end
	else
	  $display("FIFO is Empty");
      end
    ->next;
    end
  endtask
endclass
