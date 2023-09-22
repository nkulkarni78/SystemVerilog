//This is a generator class which will randomize data & gen
//erate stimulus to be driven on the DUT. Generator class 
//has mailbox (a generic handle) to handle different packet
//of data from transaction class (parameterized of that type)

class generator;
  //create transaction class object to randomize inputs
  transaction tr;

  //create parameterized mailbox to store tr objects
  mailbox #(transaction) mbx;

  //initial count value for number of randomizations
  int count = 0 ;

  //create two event handle to maintain synchronization
  event next;
  event done;

  //create object of mailbox of type transaction class
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
    tr=new();
  endfunction

  //create a task to randomize until the given count
  task run();
    repeat(count)
    begin
      //assert statement evaluates next line if condition
      //fails. $error is error defining construct in SV.
      assert(tr.randomize)
        else $error("Randomization failed");

      //put transaction object copy in mailbox
      mbx.put(tr.copy);
      //display statement to say generated one packet
      $display("GEN");

      //event statement to initiate next event
      @(next);
    end

    //trigger done event after all the packets are generated
    ->done;
  endtask
endclass
