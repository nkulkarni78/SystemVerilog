//This is seventh assignment from Udemy SV course. Task is 
//to create two arrays of same size and use $urandom to st-
//ore values in each of them, and display values with sing-
//le line statement.

module randarray;
  reg a[15]='{default:0},b[15]='{default:0};
  initial
  begin
  foreach(a[i])
  begin
    a[i]=$urandom(1+i);
    b[i]=$urandom(56);
  end
  $display("arr1: %0p\narr2: %0p",a,b);
  end
endmodule
