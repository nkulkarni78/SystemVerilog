//This is nineth assignment in Udemy SV course. Task is to
//create fixed size array of 20 elements and add random va-
//lues to array. Create queue and dynamically allocate size
//20. Add last to first of array elements as first to last
//in queue. Print elements from array and queue.


module queue;
  int a[20];
  int b[$];
  int i;
  initial
  begin
    foreach(a[i])
    begin
      a[i]=$urandom;
    end
    $display("a: %0p",a);
    for(i=0;i<20;i++)
      b.push_front(a[i]);
    $display("b: %0p",b);
  end
endmodule
