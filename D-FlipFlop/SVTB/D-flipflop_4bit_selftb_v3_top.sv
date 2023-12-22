// top module for D-flipflop program block for version 1

module top;
  // interface instance
  d_intf dff_intf_inst();

  // DUT instance
  dff dff_inst(dff_intf_inst);

  // program block instance for stimuli generation
  dff_tb dff_tb_inst(dff_intf_inst);

  initial dff_intf_inst.clock = 1'b0;

  always #5 dff_intf_inst.clock = !dff_intf_inst.clock;
endmodule
