class monitor;
  virtual FIFO_Intf dut_mon_if;
  mailbox #(transaction) mon_mbx;
  transaction tr_obj;
  
  
  function new(mailbox #(transaction) mon_mbx);
    this.mon_mbx = mon_mbx;
  endfunction
  
  task run();
    tr_obj = new();
    forever
      begin
        repeat(3)@(posedge dut_mon_if.clock);
    	tr_obj.write_en = dut_mon_if.write_en;
    	tr_obj.read_en = dut_mon_if.read_en;
        tr_obj.data_in = dut_mon_if.data_in;
        tr_obj.fifo_full = dut_mon_if.fifo_full;
        tr_obj.fifo_empty = dut_mon_if.fifo_empty;
        @(posedge dut_mon_if.clock);
        tr_obj.data_out = dut_mon_if.data_outp;

        mon_mbx.put(tr_obj);
        $display("[Time: %0t] [Monitor] Write_enable: %0d, Read_enable: %0d, data_in: %0d, data_out: %0d, FIFO_full: %0d, FIFO_empty: %0d", $time,  tr_obj.write_en,  tr_obj.read_en, tr_obj.data_in, tr_obj.data_out, tr_obj.fifo_full, tr_obj.fifo_empty);
      end
  endtask: run
endclass: monitor
