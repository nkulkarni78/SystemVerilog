// We design a FIFO module as per the given specifications in the question.
// The size of the fifo block will be sixteen bytes since the data consumer
// will be quiescent for 2 clock cycles. This is a sample question.

// Module definition
module fifo(
  // clock and reset are to reset and trigger fifo write_en pin allows to 
  // write data into fifo read_en pin allows to read data from fifo
  input clock, reset,
  input read_en, write_en,
  // input data bus which accepts 8-bits of incoming data
  input [7:0] data_in,
  // output data bus which sends out 8-bits of data 
  output [7:0] data_outp,
  // flags to track if the fifo is empty or full.
  output reg fifo_full, fifo_empty);
 
  // Memory to store incoming data into fifo buffer when data consumer is 
  // dormant. Required for 16 cycles
  reg [7:0] memory_buffer[15:0];

  // reg to store output data which is continuosly driven at output
  reg [7:0] data_out;

  assign data_outp = (read_en == 1) ? data_out : 8'bxxxx_xxxx;  

  // variable to clear buffer memory
  integer i;
  // Since memory size is more than one we need to track which location the
  // incoming data is being written and also when the consumer requires da
  // ta we need a pointer to send out the data while reading from FIFO.
  
  // Declaring register type variables to track above cases.
  reg [3:0]read, write;
  
  // variable to count elements in FIFO
  reg [4:0]count = 0;

  // Using posedge of clock as trigger event since data is processed on every
  // positive edge of clock cycle.
  always@(posedge clock)
    begin
      // Reset condition is to clear output, memory pointer and buffer memory.
      if (reset == 1'b1)
        begin
          data_out = 8'b00000000;
          for(i=0; i<16; i=i+1)
            begin
                memory_buffer[i] = 8'b00000000;
            end
          read = 4'b0000;
          write = 4'b0000;
          fifo_full = 1'b0;
          fifo_empty = 1'b0;
          count = 0;
        end
    else
      // If reset is not high, we perform data manipulation on FIFO
      begin
        // Check if there is incoming data by write_enable high and using
        // flag to check if buffer is full.
        if ((write_en == 1'b1)  && (fifo_full == 1'b0))
          begin
            // Write the information into expected location
            memory_buffer[write] = data_in;
            // Increment memory pointer after writing data 
            write = write + 1;
            // Increment counter to keep track of data elements in FIFO
            count = count + 1;
          end
        
        // Check if read is enabled and read data from FIFO memory. Include
        // condition to check if FIFO is empty while reading
        if((read_en == 1'b1) && (fifo_empty == 1'b0))
          begin
            // Send out the data on output data bus
            data_out  = memory_buffer[read];
            // Increment the read pointer for memory location
            read = read + 1;
            // decrement counter to keep track of unread data elements
            count = count - 1;
          end
        
        // Flag setting conditions when data is being lost or wrongly read. 
        // Write flag is set when FIFO is full and write_en is high. When 
        // read is still at initial memory location then fifo is full and 
        // reading is not active for next cycle.
        if(count == 16)
            fifo_full = 1;
        else
            fifo_full = 0;
        // If read is at last location and write is also at last location 
        // then fifo is empty and no new data is present.
        if(count == 0)
            fifo_empty = 1;
        else
            fifo_empty = 0;
      end
   end
endmodule
