//This is the interface for our design

interface ifc;
  //design inputs/outputs are logic types in interface
  logic clock, reset, read_en, write_en;
  logic [7:0] data_in;
  logic [7:0] data_out;
  logic fifo_full,fifo_empty;
endinterface
