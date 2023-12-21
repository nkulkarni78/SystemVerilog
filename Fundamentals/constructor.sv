//This is fourteenth assignment in SV Udemy course. Task is
//to create custom constructor allowing user to enter data.

class test;
  bit unsigned [7:0]a,b,c;

  function new(bit unsigned [7:0] a,b,c);
    this.a=a;
    this.b=b;
    this.c=c;
  endfunction
endclass

module task_tb;
  test t;
  initial
  begin
    t=new(2,4,56);
    #5 $display("%0d %0d %0d",t.a,t.b,t.c);
  end
endmodule
