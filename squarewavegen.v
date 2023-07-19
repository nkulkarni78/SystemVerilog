//This is second assignment from Udemy courseware. The task
//is to generate a 9MHz square wave with timescale 1ns  and
//precision for 3 decimals.

`timescale 1ns/1ps;
module squarewavegen;
  reg sclk;
  always #55.555 sclk = ~sclk;
  initial
  begin
    sclk = 1'b0;
  end

  initial
  begin
    $dumpfile("squarewave.vcd");
    $dumpvars(0,squarewavegen);
    #9000 $finish;
  end
endmodule
