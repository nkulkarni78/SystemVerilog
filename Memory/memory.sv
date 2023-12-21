// This is a memory module of size 32kb. Each location holds 8-bit data and we 
// have 4096 locations to write data. Whenever read bit is high we read data
// from given location and do not write any data to given location. Whenever
// write bit is high we write data to the given location and read operation is
// nullified. Since there are 4096 locations we need 12 bits for address. We
// shall design positive edge triggered active high synchronous reset memory.


module memory(readData, writeData, readEnable, WriteEnable, clock, reset);
  //port declarations with parameters that can be changed dynamically
  parameter DATA_SIZE = 8;
  parameter ADDR_SIZE = 4096;
  
  // since you write data into memory it is input
  input [DATA_SIZE-1:0]writeData;
  input clock, reset, readEnable, writeEnable;
  // since you read data from memory it is output
  output reg [DATA_SIZE-1:0]readData;
  reg [DATA_SIZE-1:0]Mem[ADDR_SIZE-1:0];

  always_ff(posedge clock)
  begin
    if()
  end

endmodule
