//We design a FIFO module as per the given specifications 
//in the question.The size of the fifo block will be sixt- 
//een bytes since the data consumer will be quiescent for 
//2 clock cycles.

//Module definition
module fifo(
  //clock and reset are to reset and trigger fifo
  //write_en pin allows to write data into fifo
  //read_en pin allows to read data from fifo
  input clock, reset,
  input read_en, write_en,
  //input data bus which accepts 8-bits of incoming data
  input [7:0] data_in,
  //output data bus which sends out 8-bits of data 
  output reg [7:0] data_out,  
  //flags to track if the fifo is empty or full.
  output reg fifo_full, fifo_empty);
 
  //Memory to store incoming data into fifo buffer when data
  //consumer is dormant.Required for 16 cycles
  reg [7:0] memory_buffer[15:0];
  
  //variable to clear buffer memory
  integer i;
  //Since memory size is more than one we need to track whi
  //ch location the incoming data is being written and also
  //when the consumer requires data we need a pointer to se
  //nd out the data while reading from FIFO.
  
  //Declaring register type variables to track above cases.
  reg read, write;
  
  //To check if read and write is complete and track flags.
  //reg read_complete, write_complete;
  

  //varialble to count elements in FIFO
  reg [4:0]count = 0;
  //Using posedge of clock as trigger event since data is 
  //processed on every positive edge of clock cycle.
  always@(posedge clock)
    begin
      //Reset condition is to clear output, memory pointer
      // and buffer memory of FIFO
      if (reset == 1'b1)
        begin
          data_out <= 8'b00000000;
          for(i=0;i<16;i=i+1)
            begin
                memory_buffer[i] <= 8'b00000000;
            end
          read <= 1'b0;
          write <= 1'b0;
          fifo_full <= 1'b0;
          fifo_empty <= 1'b0;
          count <= 0;
          //write_complete <= 1'b0;
          //read_complete <= 1'b0;
        end
    else
      //if reset is not asserted, we perform data manipula-
      //tion on FIFO
      begin
        //Check if there is incoming data by write_enable 
        //bus and using flag to check if buffer is full.
        if ((write_en == 1'b1)  && (fifo_full == 1'b0))
          begin
            //Write the information into expected location
            memory_buffer[write] = data_in;
            //Increment memory pointer after writing data 
            write = write + 1;
            count = count + 1;
            //confirm writing is completed. This is used to
            // hold data when read is low.
            //write_complete = write_complete + 1;
          end
        
        //Check if read is enabled and read data from FIFO 
        //memory. Include condition to check if FIFO is em
        //pty while reading
        if((read_en == 1'b1) && (fifo_empty == 1'b0))
          begin
            //Send out the data on output data bus
            data_out  = memory_buffer[read];
            //Increment the read pointer for memory location
            read = read + 1;
            count = count - 1;
            //Confirm read is completed. This holds data when
            //write is high and willing to load data.
            //read_complete = read_complete + 1;
          end
        
        //If both read and write are high reset the location
        //pointers as the data written was read out.
        //if(read_en == 1'b0)
        //  begin
        //  //Hold data at that point as read is still incomp
        //  //lete and we cannot write new data
        //    read_complete = read_complete - 1;
        //  end
        //  if(write_en == 1'b0)
        //  begin
        //  //hold the data at that point since write is comp
        //  //leted and read is not complete.
        //    write_complete = write_complete - 1;
        //  end
        //Flag setting conditions when data is being lost 
        //or wrongly read. Write flag is set when FIFO is 
        //full and write_en is high. When read is still at 
        //initial memory location then fifo is full and 
        //reading is not active for next cycle.
        if(count == 16)
            fifo_full = 1;
        else
            fifo_full = 0;
        //If read is at last location and write is also at 
        //last location then fifo is empty and no new data
        // is present.
        if(count == 0)
            fifo_empty = 1;
        else
            fifo_empty = 0;
      end
   end
endmodule
