// top module to instantiate DUT and Testbench

module top;
  reg clock;
  reg reset;
  env env_obj;
  mem_intf intf_instance(clock, reset);

  memory mem_instance(intf_instance.dut_ports);

  initial
  begin
    env_obj = new(intf_instance);
    reset = 1'b0;
    clock = 1'b0;
    #2 reset = 1'b1;
    #5 reset = 1'b0;
    env_obj.gen_obj.count = 20;
    #20
    env_obj.run();
  end

  always #5 clock = ~clock;

endmodule: top
