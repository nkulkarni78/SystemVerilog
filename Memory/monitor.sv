// monitor class to monitor data output from DUT

class monitor;
  transaction tr_obj;
  mailbox #(transaction) mon_mbx;
  virtual interface mem_intf mon_mem_intf;

  function new(mailbox#(transaction) mon_mbx);
    this.mon_mbx = mon_mbx;
    tr_obj = new();
  endfunction: new

  task run();
    forever
    begin
      @(mon_mem_intf.cb);
      tr_obj.rwAddr = mon_mem_intf.rwAddr;
      tr_obj.readEnable = mon_mem_intf.readEnable;
      tr_obj.writeEnable = mon_mem_intf.writeEnable;
      tr_obj.writeData_in = mon_mem_intf.writeData_in; 
      @(mon_mem_intf.cb);
      if(mon_mem_intf.writeEnable == 1'b1)
      begin
        tr_obj.ack = mon_mem_intf.cb.ack;
        $display("Write Operation. Data Written: %0d", mon_mem_intf.writeData_in);
      end
      else
        tr_obj.ack = 1'bx;

      if(mon_mem_intf.readEnable == 1'b1)
        tr_obj.readData_out = mon_mem_intf.cb.readData_out;
      else
        tr_obj.readData_out = 8'bx;

     @(mon_mem_intf.cb);
        mon_mbx.put(tr_obj);
      $display("[Time: %0t] [Monitor]: Data received from DUT. Read?: %0b. \
Write?: %0b, Location: %0b", $time, tr_obj.readEnable,
                tr_obj.writeEnable, tr_obj.rwAddr);
      @(mon_mem_intf.cb);
    end
  endtask: run
endclass: monitor
