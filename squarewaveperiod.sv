//This is fourth assignment from Udemy SV courseware. Task
//is to generate a squarewave with period of 40ns and duty
//cycle of 0.4. Phase difference with reference clock is 0.
//The term Duty Cycle refers to time for which signal rema-
//ins high.

`timescale 1ns/1ns;
module squareduty4;
  reg clk, duty;

  always #20 clk = ~clk;
  always
  begin
    #24 duty=1'b1;
    #16 duty=1'b0;
  end

  initial
  begin
    clk = 1'b0;
    duty = 1'b0;
  end
  
  initial
  begin
    $dumpfile("dutycycle.vcd");
    $dumpvars(0,squareduty4);
    #1000 $finish;
  end
endmodule
