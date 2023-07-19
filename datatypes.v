//This is fifth assignment in Udemy SV courseware. Task is 
//to demonstrate the differnt datatypes.

`timescale 1ns/1ns;
module datatypes;
  reg [7:0]a,b;
  integer c,d;

  initial
  begin
    a=12;
    b=34;
    c=67;
    d=255;

    $display("a: %0d",a);
    #12 $display("b: %0d",b);
    #12 $display("c: %0d",c);
    #12 $display("d: %0d",d);
  end
endmodule
