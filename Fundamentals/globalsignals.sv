//This is the first assignment from Udemy courseware on the
//SystemVerilog.

`timescale 1ns/1ps;
module tb;
  reg resetn,clk;
  initial
  begin
    resetn = 1'b0;
    clk = 1'b0;
    #60 resetn = 1'b1;
  end

  initial
  begin
    $dumpfile("dump.vcd");
    $dumpvars;
    $monitor("clk: %2d\nreset: %2d",clk,resetn);
  end
endmodule
