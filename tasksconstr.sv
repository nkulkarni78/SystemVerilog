//This is fifteenth assignemnt in SV Udmeny course. Task is
//to create a task inside class that will return the sum of
//given inputs. Task should also print results to console.

class task2const;
  bit [3:0]a,b,c;
  bit [4:0]sum;
  function new(input bit [3:0]a=0,b=0,c=0,output bit [4:0]sum);
    this.a=a;
    this.b=b;
    this.c=c;
    this.sum=sum;
  endfunction

  task summation();
    $display("a=%0d b=%0d c=%0d",a,b,c);
    sum = a+b+c;
  endtask
endclass

module tb;
  bit[4:0]s;
  task2const tc;
  initial
  begin
    tc=new(.a(1),.b(2),.c(4),.sum(s));
    tc.summation();
    $display("%0d",tc.sum);
  end
endmodule
