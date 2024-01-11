`include "generator.sv"

class driver;
  mailbox#(transaction) drv_mbx;
  virtual FIFO_Intf drv_dut_if;
  transaction test_data;
  
  function new(mailbox #(transaction) drv_mbx);
    this.drv_mbx = drv_mbx;
  endfunction
  
  task reset();
    drv_dut_if.reset <= 1'b1;
    drv_dut_if.read_en <= 0;
    drv_dut_if.write_en <= 0;
    drv_dut_if.data_in <= 8'd0;
    repeat(2)@(posedge drv_dut_if.clock);
    drv_dut_if.reset <= 1'b0;
    $display("[Time: %0t] [Driver] Reset Completed.", $time);
    $display("---------------------------------------------");
  endtask: reset
  
  task write();
    @(posedge drv_dut_if.clock);
    drv_dut_if.reset <= 1'b0;
    drv_dut_if.data_in <= test_data.data_in;
    drv_dut_if.write_en <= 1'b1;
    drv_dut_if.read_en <= 1'b0;
    @(posedge drv_dut_if.clock);
    $display("[Time: %0t] [Driver] Write Completed. Data Written: %0d", $time,  drv_dut_if.data_in);
    @(posedge drv_dut_if.clock);
  endtask: write
  
  task read();
    @(posedge drv_dut_if.clock);
    drv_dut_if.read_en <= 1'b1;
    drv_dut_if.write_en <= 1'b0;
    repeat(2)@(posedge drv_dut_if.clock);
    $display("[Time: %0t] [Driver] Read Completed.", $time);
    @(posedge drv_dut_if.clock);
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
