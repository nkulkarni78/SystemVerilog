//This is thirteenth assignment in SV Udemy course. Task is
//to create a function that will generate & store 32 values
//of multiples of 8 and prints them to console.

module tb;
  function int multiply(int a, int b);
    return a*b;
  endfunction

  int i=0,arr[32];
  initial
  begin
    for(i=0;i<32;i=i+1)
    begin
      arr[i]=multiply(8,i);
    end
    #10
    for(i=0;i<32;i=i+1)
    begin
      $display("arr[%0d]=%0d",i,arr[i]);
    end
  end
endmodule
