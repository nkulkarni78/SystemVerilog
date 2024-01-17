// transaction class which will be used by generator to generate random
// stimulus to test design. We randomly perform read and write operation
// and observe if the design reads and writes data in FIFO order

class transaction;
  // rand bit for selecting read or write operation
  randc bit operation;
  bit write_en,read_en;
  // random data input that can be stored in FIFO
  rand bit [7:0]data_in;
  bit fifo_full, fifo_empty;
  bit [7:0]data_out;
endclass: transaction
