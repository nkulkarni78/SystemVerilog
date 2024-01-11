`include "interface.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "env.sv"

module top;
  FIFO_Intf intf();
  fifo fifo_inst(.clock(intf.clock),
                 .reset(intf.reset),
                 .read_en(intf.read_en),
                 .write_en(intf.write_en),
                 .data_in(intf.data_in),
                 .data_outp(intf.data_outp),
                 .fifo_full(intf.fifo_full),
                 .fifo_empty(intf.fifo_empty));
  
  initial intf.clock = 0;
  
  always #5 intf.clock = ~intf.clock;
  
  environment env;
  
  initial
    begin
      env = new(intf);
      env.gen.count = 20;
      env.run();
    end
  
endmodule: top
