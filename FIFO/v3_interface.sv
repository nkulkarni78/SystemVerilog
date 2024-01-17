// interface which connects dUT ports with testbench. Since earlier design
// and testbench had synchronization issues we used clocking block to mai-
// ntain the order of transactions and clock is independent & synchronous 
// to entire design and testbench environment. Interface requires clock as
// input to drive stimulus accordingly in the entire environment.

interface FIFO_Intf(input clock);
  logic reset, read_en, write_en;
  logic [7:0] data_in, data_outp;
  logic fifo_full, fifo_empty;
  
  default clocking cb @(posedge clock);
    output reset, read_en, write_en, data_in;
    input data_outp, fifo_full, fifo_empty;
  endclocking
  
  modport dut_ports (input reset, read_en, write_en, data_in,
                     output data_outp, fifo_full, fifo_empty);
  modport tb_ports (clocking cb);
  
  
endinterface: FIFO_Intf
