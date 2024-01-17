`include "interface.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "env.sv"

module top;
  reg clock;
  
  FIFO_Intf intf_inst(clock);
  
  fifo fifo_inst(intf_inst.dut_ports);
  
  initial clock = 0;
  
  always #5 clock = ~clock;
  
  environment env;
  
  initial
    begin
      env = new(intf_inst);
      env.gen.count = 20;
      env.run();
    end
  
  /*initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars();
    end
  */
endmodule: top
