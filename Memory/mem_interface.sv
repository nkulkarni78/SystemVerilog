// interface for memory module

interface mem_intf(input clock, input reset);
  logic readEnable;
  logic writeEnable;
  logic [11:0]rwAddr;
  logic [7:0] writeData_in;
  logic [7:0] readData_out;
  logic ack;

  // clocking block
  default clocking cb@(posedge clock);
    default input #1step;
    default output negedge;
    output reset, readEnable, writeEnable, rwAddr, writeData_in;
    input readData_out, ack;
  endclocking: cb

  // modports for design
  modport dut_ports (input readEnable, writeEnable, rwAddr,
                     writeData_in, output readData_out, ack);

  // modports for testbench
  modport tb_ports (clocking cb);

endinterface: mem_intf
