class transaction;
  rand bit readEnable;
  rand bit writeEnable;
  rand bit [11:0] rwAddr;
  rand bit [7:0] writeData_in;
       bit [7:0] readData_out;
       bit ack; 

  function void copy(transaction obj);
    this.readEnable = obj.readEnable;
    this.writeEnable = obj.writeEnable;
    this.rwAddr = obj.rwAddr;
    this.writeData_in = obj.writeData_in;
    this.readData_out = obj.readData_out;
    this.ack = obj.ack;
  endfunction: copy

  constraint c1 {writeEnable != readEnable;}
  constraint c2 {rwAddr < 20;}

  covergroup cg;
    coverpoint readEnable {
      bins all[] = {0,1};
    }

    coverpoint writeEnable {
      bins all[] = {0,1};
    }

    coverpoint rwAddr {
      bins lower_address = {[0:10]};
      bins higher_address = {[11:19]};
      illegal_bins remains = {[20:$]};
    }
  endgroup

  function new();
    cg = new();
  endfunction: new

endclass: transaction
