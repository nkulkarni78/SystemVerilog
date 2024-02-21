// scoreboard to compare received data and display results;
class scoreboard;
  transaction tr_obj, ref_obj;
  mailbox#(transaction) scb_mbx;
  event next;
  int ref_data[int];  
  int error = 0;

  function new(mailbox#(transaction) scb_mbx);
    this.scb_mbx = scb_mbx;
    ref_obj = new();
  endfunction: new

  task run();
    forever
    begin
      scb_mbx.get(tr_obj);
      $display("[Time: %0t] [Scoreboard]: Data retrieved. Read?: %0b. \
Write?: %0b, Location: %0b, Data Written: %0d", $time, tr_obj.readEnable,
                tr_obj.writeEnable, tr_obj.rwAddr, tr_obj.writeData_in);

      // create a copy of transaction object to generate golden data
      ref_obj.copy(tr_obj);

      if(ref_obj.writeEnable == 1'b1)
        ref_data[ref_obj.rwAddr] = ref_obj.writeData_in;

      // Scoreboard logic to validate data from golden data
      if(tr_obj.writeEnable == 1'b1)
      begin
        $display("[Time: %0t] [Scoreboard] Data is written into Memory. Location: %0b, Data_in: \
%0d, ACK: %0d", $time, tr_obj.rwAddr, tr_obj.writeData_in, tr_obj.ack);
        if(tr_obj.ack != 1'b1)
        begin
          $display("[Error]: No Acknowledgement received.!!");
          error++;
        end
      end
      
      if(tr_obj.readEnable == 1'b1)
      begin
        if(ref_data.exists(tr_obj.rwAddr))
        begin
          if(ref_data[tr_obj.rwAddr] == tr_obj.readData_out)
            $display("[Scoreboard]: TEST PASSED for READ");
          else
          begin
            $display("[Scoreboard]: TEST FAILED for READ. Exp: %0d, Act: %0d",
                     ref_data[tr_obj.rwAddr],tr_obj.readData_out);
            error++;
          end
        end
        else
          $display("New Location/Location Empty: %0b. Read Data: %0b",tr_obj.rwAddr, tr_obj.readData_out);
      end
      $display("--------------------------------------------------------------------------------");
      ->next;
    end
  endtask: run
endclass: scoreboard
