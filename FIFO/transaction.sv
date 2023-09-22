//This is transaction class for FIFO design. This contains 
//randomization parameters for required inputs, function to
//display any values that are randomized in when the object
//is called.

class transaction;
  //randomly change read and write enable
  rand bit read_en, write_en;
  //randomize data input for FIFO
  rand bit [7:0]data_in;

  bit fifo_full,fifo_empty;
  bit [7:0]data_out;

  //give constraints which will maintain design integrity
  constraint c1 {{write_en != read_en};
                 write_en dist {0:/50,1:/50};
                 read_en dist {0:/50,1:/50};}

  constraint c2 {1 <= data_in <= 128;}

  //function to display variables randomized
  function void display(input string id);
    $display("[%0s]: Write_en: %0b\t,Read_en: %0b\t,Data_i\
n: \%0b\t,Data_out: %0b\t, fifo_full: %0b\t, fifo_empty: %b\
\t",id,write_en,read_en,data_in,data_out,fifo_full,fifo_empty);
  endfunction

  //create a copy of trasaction everytime as new data will
  //be generated for every randomization. return type will
  //be of type transaction class since it contains all the
  //variables of that class
  function transaction copy();
    //create new object for that class
    copy = new();
    //Read data into copy object from given data in class
    copy.read_en = this.read_en;
    copy.write_en = this.write_en;
    copy.data_in = this.data_in;
    copy.fifo_full = this.fifo_full;
    copy.fifo_empty = this.fifo_empty;
    copy.data_out = this.data_out;
  endfunction
endclass
