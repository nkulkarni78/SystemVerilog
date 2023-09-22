//top module

module top;
  //interface declaration
  ifc itfc();

  //DUT instantiation
  fifo dut(itfc.clock,
           itfc.reset,
           itfc.read_en,
           itfc.write_en,
           itfc.data_in,
           itfc.data_out,
           itfc.fifo_full,
           itfc.fifo_empty);

  initial
  begin
    itfc.clock <= 1'b0;
  end

  always #10 itfc.clock = ~itfc.clock;

  env env_obj;

  initial
  begin
    env_obj = new(itfc);
    env_obj.gen.count = 20;
    env_obj.run();
  end 

  initial
  begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
endmodule
