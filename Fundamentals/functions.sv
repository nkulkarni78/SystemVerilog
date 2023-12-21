//This is eleventh assignment in SV Udemy course. Task is to
//create a function that returns multiplication of two input
//numbers and displays results by comparing with expected
//output from multiplication.

module functiontest;
  function int multiply(int unsigned a, int unsigned b);
    return a*b;
  endfunction

  integer unsigned c;
  initial
  begin
    c=multiply(5,6);
    $display(c);
    if(c==(5*6))
      $display("TEST PASSED");
    else
      $display("TEST FAILED");
  end
endmodule
