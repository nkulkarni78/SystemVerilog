// top module for D-flipflop program block for version 1

module top;
  logic clock;
  logic top_reset;
  logic [3:0]top_d;
  logic [3:0]top_q;

  // DUT instance
  dff dff_inst(.d(top_d), .q(top_q), .clk(clock), .reset(top_reset));

  // program block instance for stimuli generation
  dff_tb dff_tb_inst(.tb_clk(clock),
                     .tb_reset(top_reset),
                     .tb_d(top_d),
                     .tb_q(top_q));

  initial clock = 1'b0;

  always #5 clock = !clock;
endmodule
