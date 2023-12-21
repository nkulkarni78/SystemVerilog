//This is sixth assignment from Udemy SV courseware. Task
//is to initialize array elements as square of index values

`timescale 1ns/1ns;

module arr;
  integer unsigned a[10];
  initial
  begin
    foreach(a[i])
      a[i]=i*i;
    foreach(a[i])
    $display("%d ",a[i]);
  end
endmodule
