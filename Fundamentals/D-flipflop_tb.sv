module test;
    logic clk,reset;
    logic d;
    logic q;

    dff d1(.clk(clk),.reset(reset),.d(d),.q(q));

    always #5 clk = ~clk;

    initial
    begin
        clk = 1'b0;
        reset = 1'b0;
        #5 reset = 1'b1;
    end

    initial
    begin
        d = 1'b0;
        #5 d = 1'b1;
        #5 d = 1'b0;
        #5 d = 1'b1;
        #5 d = 1'b1;
        #5 d = 1'b0;
    end

    initial
    begin
       $monitor("clk = %b, reset = %b, d = %b, q = %b",clk,reset,d,q);
       #40 $finish;
    end
endmodule
