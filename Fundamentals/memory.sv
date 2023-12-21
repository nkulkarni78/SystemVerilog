// This is a memory module of size 32kb. Each location holds 8-bit data and we 
// have 4096 locations to write data. Whenever read bit is high we read data
// from given location and do not write any data to given location. Whenever
// write bit is high we write data to the given location and read operation is
// nullified. Since there are 4096 locations we need 12 bits for address. We
// shall design positive edge triggered active high synchronous reset memory.


module memory(readData, writeData, readEnable, writeEnable, rw_Addr, clock, reset);
  //port declarations with parameters that can be changed dynamically
  parameter DATA_SIZE = 8;
  parameter ADDR_SIZE = 4096;
  
  // since you write data into memory it is input
  input [DATA_SIZE-1:0]writeData;
  input clock, reset, readEnable, writeEnable;

  input [11:0]rw_Addr;
  // since you read data from memory it is output
  output reg [DATA_SIZE-1:0]readData;

  // memory bank to store data
  reg [DATA_SIZE-1:0]Mem[ADDR_SIZE-1:0];

  always_ff@(posedge clock)
  begin
    if(reset)
      for(int i=0; i<ADDR_SIZE; i++)
      begin
        Mem[i] <= 8'b0000_0000;
        readData <= 8'b0000_0000;
      end

    else
    begin
      if(readEnable)
      begin
        readData <= Mem[rw_Addr];
      end
      if(writeEnable)
      begin
        Mem[rw_Addr] <= writeData;
      end
    end
  end

endmodule
