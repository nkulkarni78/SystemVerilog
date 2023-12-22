// top module for D-flipflop program block for version 2 with interface instance 
// port connections

module top;

  // interface instance
  d_intf intf_inst();

  // DUT instance
  dff dff_inst(.d(intf_inst.tb_d),
               .q(intf_inst.tb_q),
               .clk(intf_inst.clock),
               .reset(intf_inst.tb_reset));

  // program block instance for stimuli generation
  dff_tb dff_tb_inst(.tb_clk(intf_inst.clock),
                     .tb_reset(intf_inst.tb_reset),
                     .tb_d(intf_inst.tb_d),
                     .tb_q(intf_inst.tb_q));

  initial intf_inst.clock = 1'b0;

  always #5 intf_inst.clock = !intf_inst.clock;
endmodule
