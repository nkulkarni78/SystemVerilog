//This is eighth assignment from Udemy SV course. Task is
//to create a dynamic array capable of storing 7 elements
//multiples of 7 and after 20ns size is updated to 20 and
//update rest 13 elements with multiples of 5.

`timescale 1ns/1ns;
module dynamicarrays;
  int a[];
  int i,j=1;
  initial
  begin
    a=new[7];
    a[0]=7;
    for(i=1;i<7;i++)
      a[i]=7*(i+1);
    $display("array[7]: %0p",a);
    #20
    a=new[20](a);
    for(i=7;i<20;i++)
    begin
      a[i]=5*j;
      j++;
    end
    $display("array[20]: %0p",a);
  end
endmodule
