// driver class which will drive the stimulus into dut

class driver;
  transaction tr_obj;
  mailbox #(transaction) drv_mbx;
  virtual interface mem_intf drv_mem_intf; 

  function new(mailbox #(transaction) drv_mbx);
    this.drv_mbx = drv_mbx;
  endfunction: new

  // task to drive data as per enabled conditions
  task run();
    forever
    begin
      drv_mbx.get(tr_obj);
      drv_mem_intf.cb.rwAddr <= tr_obj.rwAddr;
      drv_mem_intf.cb.writeEnable <= tr_obj.writeEnable;
      drv_mem_intf.cb.readEnable <= tr_obj.readEnable;

      if(tr_obj.writeEnable == 1'b1)
        drv_mem_intf.cb.writeData_in <= tr_obj.writeData_in;
      else
        drv_mem_intf.cb.writeData_in <= 8'bx;

      @(drv_mem_intf.cb);
      $display("[Time: %0t] [Driver]: Data given to DUT. Read?: %0b. \
Write?: %0b, Location: %0b", $time, tr_obj.readEnable,
                tr_obj.writeEnable, tr_obj.rwAddr);
      @(drv_mem_intf.cb);
    end
  endtask: run

endclass: driver
