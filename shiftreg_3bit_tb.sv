module test;
    logic clk,reset;
    logic [2:0]q;
    logic d;

    shiftreg_3bit s1(.clk(clk), .reset(reset),
                     .q(q),.d(d));

    always #5 clk = ~clk;

    initial
    begin
        reset = 1'b0;
        clk = 1'b0;
        #6 reset = 1'b1; 
    end

    initial
    begin
        #10 d = 1'b1;
        #5  d = 1'b0;
        #5  d = 1'b1;
        #5  d = 1'b1;
        #5  d = 1'b0;
    end

    initial
    begin
       $dumpvars(0);
       $dumpfile("shiftregister.vcd");
       $monitor($time, " d = %b, q[0]=%b, q[1]=%b, q[2]=%b",d,q[0],q[1],q[2]);
       #100 $finish;
    end
endmodule
