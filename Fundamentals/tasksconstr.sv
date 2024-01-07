//This is fifteenth assignemnt in SV Udmeny course. Task is
//to create a task inside class that will return the sum of
//given inputs. Task should also print results to console.

class task2const;
  // bit [3:0]a,b,c;
  // bit [4:0]sum;

  task summation(input [3:0]a,b,c, output[4:0]sum);
    sum = a+b+c;
    $display("a=%0d b=%0d c=%0d, sum=%0d",a,b,c,sum);
  endtask
endclass

module tb;
  bit [4:0] sum;
  task2const tc;
  initial
  begin
    tc=new();
    tc.summation(1,2,4, sum);
  end
endmodule
