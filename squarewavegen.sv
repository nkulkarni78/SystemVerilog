//This is second and third assignment from Udemy courseware
//The task is to generate a 9MHz square wave with timescale
//1ns  and precision for 3 decimals.

`timescale 1ns/1ps;
module squarewavegen;
  reg sclk;
  reg clk25;
  always #55.555 sclk = ~sclk;
  always #20.00 clk25 = ~clk25;
 
  initial
  begin
    sclk = 1'b0;
    clk25 = 1'b0;
  end

  initial
  begin
    $dumpfile("squarewave.vcd");
    $dumpvars(0,squarewavegen);
    #9000 $finish;
  end
endmodule
