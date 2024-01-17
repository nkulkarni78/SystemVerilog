// Module definition. Design Version 3 is developed with interface modports.
// All the port connections in design are now with respect to interface.

module fifo(FIFO_Intf intf_design_ports);
 
  // Memory to store incoming data into fifo buffer when data consumer is 
  // dormant. Required for 16 cycles
  reg [7:0] memory_buffer[15:0];

  // reg to store output data which is continuosly driven at output
  
  reg [7:0] data_out;

  assign intf_design_ports.data_outp = (intf_design_ports.read_en == 1) ? data_out : 8'bxxxx_xxxx;  

  // Since memory size is more than one we need to track which location the
  // incoming data is being written and also when the consumer requires da
  // ta we need a pointer to send out the data while reading from FIFO.
  
  // Declaring register type variables to track above cases.
  reg [3:0]read, write;
  
  // variable to count elements in FIFO
  reg [4:0]count = 0;

  // Using posedge of clock as trigger event since data is processed on every
  // positive edge of clock cycle.
  always@(posedge intf_design_ports.clock)
    begin
      // Reset condition is to clear output, memory pointer and buffer memory.
      if (intf_design_ports.reset == 1'b1)
        begin
          data_out <= 8'b00000000;
          for(int i=0; i<16; i=i+1)
            begin
              memory_buffer[i] <= 8'b00000000;
            end
          read <= 4'b0000;
          write <= 4'b0000;
          // design outputs are connected through interface to TB
          intf_design_ports.fifo_full <= 1'b0;
          intf_design_ports.fifo_empty <= 1'b0;
          count <= 0;
        end
    else
      // If reset is not high, we perform data manipulation on FIFO
      begin
        // Check if there is incoming data by write_enable high and using
        // flag to check if buffer is full.
        if ((intf_design_ports.write_en == 1'b1)  &&
            (intf_design_ports.fifo_full == 1'b0))
          begin
            // Write the information into expected location
            memory_buffer[write] <= intf_design_ports.data_in;
            // Increment memory pointer after writing data 
            write <= write + 1;
            // Increment counter to keep track of data elements in FIFO
            count <= count + 1;
          end
        
        // Check if read is enabled and read data from FIFO memory. Include
        // condition to check if FIFO is empty while reading
        if((intf_design_ports.read_en == 1'b1) &&
           (intf_design_ports.fifo_empty == 1'b0))
          begin
            // Send out the data on output data bus
            data_out  <= memory_buffer[read];
            // Increment the read pointer for memory location
            read <= read + 1;
            // decrement counter to keep track of unread data elements
            count <= count - 1;
          end
        
        // Flag setting conditions when data is being lost or wrongly read. 
        // Write flag is set when FIFO is full and write_en is high. When 
        // read is still at initial memory location then fifo is full and 
        // reading is not active for next cycle.
        if(count == 16)
            intf_design_ports.fifo_full = 1;
        else
            intf_design_ports.fifo_full = 0;
        // If read is at last location and write is also at last location 
        // then fifo is empty and no new data is present.
        if(count == 0)
            intf_design_ports.fifo_empty = 1;
        else
            intf_design_ports.fifo_empty = 0;
      end
   end
endmodule
