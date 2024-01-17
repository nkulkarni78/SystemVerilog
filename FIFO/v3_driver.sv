`include "generator.sv"

class driver;
  mailbox#(transaction) drv_mbx;
  virtual FIFO_Intf drv_dut_if;
  transaction test_data;
  
  function new(mailbox #(transaction) drv_mbx);
    this.drv_mbx = drv_mbx;
  endfunction
  
  task reset();
    drv_dut_if.cb.reset <= 1'b1;
    drv_dut_if.cb.read_en <= 0;
    drv_dut_if.cb.write_en <= 0;
    drv_dut_if.cb.data_in <= 8'd0;
    repeat(2)@(drv_dut_if.cb);
    $display("[Time: %0t] [Driver] Reset Completed. RESET: %0d", $time, drv_dut_if.reset);
    drv_dut_if.cb.reset <= 1'b0;
    @(drv_dut_if.cb);
	$display("---------------------------------------------");
  endtask: reset
  
  task write();
	drv_dut_if.cb.data_in <= test_data.data_in;
	drv_dut_if.cb.write_en <= 1'b1;
	drv_dut_if.cb.read_en <= 1'b0;
    @(drv_dut_if.cb);
	$display("[Time: %0t] [Driver] Write Completed. Data Written: %0d", $time,  drv_dut_if.data_in);
    @(drv_dut_if.cb);
  endtask: write
  
  task read();
    drv_dut_if.cb.read_en <= 1'b1;
    drv_dut_if.cb.write_en <= 1'b0;
    repeat(2)@(drv_dut_if.cb);
    $display("[Time: %0t] [Driver] Read Completed. ", $time);
  endtask: read
  
  task run();
    forever
      begin
        drv_mbx.get(test_data);
        if(test_data.operation == 1)
          write();
        else
          read();
      end
  endtask: run
        
endclass
