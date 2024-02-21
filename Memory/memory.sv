// This is a memory module of size 32kb. Each location holds 8-bit data and we 
// have 4096 locations to write data. Whenever read bit is high we read data
// from given location and do not write any data to given location. Whenever
// write bit is high we write data to the given location and read operation is
// nullified. Since there are 4096 locations we need 12 bits for address. We
// shall design positive edge triggered active high synchronous reset memory.

module memory#(parameter ADDR_SIZE=4096)(mem_intf dut_intf);
  // port declarations with parameters that can be changed dynamically
  parameter DATA_SIZE = 8;
  parameter ADDR_WIDTH = 12;
  
  // input clock, reset;
  // input readEnable;
  // input writeEnable;

  // since you write data into memory it is input
  // input [DATA_SIZE-1:0]dut_intf.writeData_in;

  // address to read or write data
  // input [ADDR_WIDTH-1:0]dut_rwAddr;

  // since you read data from memory it is output
  // output [DATA_SIZE-1:0]readData_out;

  // provides acknowledgement for successful write/read operation
  // output reg ack;

  // intermediate storage element to store read data
  reg [DATA_SIZE-1:0]readData;

  // memory bank for 4096 locations
  reg [DATA_SIZE-1:0]Mem[ADDR_SIZE-1:0];

  // iterating element for all memory locations
  integer i;

  // output data is high impedence if writeEnable is high
  assign dut_intf.readData_out = (dut_intf.readEnable) ? readData: 8'bzzzz_zzzz;

  always_ff@(posedge dut_intf.clock)
  begin
    if(dut_intf.reset)
    begin
      // reset all the memory locations with z as its value signifying nothing
      for(i=0; i<ADDR_SIZE; i++)
      begin
        Mem[i] <= 8'bzzzz_zzzz;
      end
    end
    else
    begin
      if(dut_intf.writeEnable && !dut_intf.readEnable)
      begin
       Mem[dut_intf.rwAddr] <= dut_intf.writeData_in;
       dut_intf.ack = 1'b1;
      end
      if(dut_intf.readEnable && !dut_intf.writeEnable)
      begin
        readData <= Mem[dut_intf.rwAddr];
        dut_intf.ack <= 1'bx;
      end
    end
  end
endmodule
