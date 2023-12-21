//This is twelvth assignment in Udemy SV course. Task is to
//define a task that generates given signal input waveform.
`timescale 1ns/1ps;

module task_tb;
  bit clk;
  bit wr=1'b0, en=1'b0;
  bit [5:0]addr;
  task wavegen();
    en=1'b1;wr=1'b1;addr=6'd12;
    #40 addr=6'd14;
    #40 addr=6'd23;wr=1'b0;
    #40 addr=6'd48;
    #40 addr=6'd56;en=1'b0;
  endtask

  always #20 clk = ~clk;
  initial
  begin
    wavegen();
    #40 $finish;
  end
endmodule
