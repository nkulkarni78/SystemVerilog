//This is the tenth assignment in Udemy SV course. Task is 
//to create a class, initialize its members with integers
//and display results using display function.

class test;
  integer unsigned a;
  integer unsigned b;
  integer unsigned c;
endclass

module test;
  test tb;
  initial
  begin
  tb=new();
  tb.a=45;
  tb.b=78;
  tb.c=90;
  #1 $display("a=%d  b=%d  c=%d",tb.a,tb.b,tb.c);
  end
endmodule
