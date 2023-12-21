module test;
    logic [1:0]in;
    logic sel;
    logic out;

    mux2x1if(.in(in),.out(out),.sel(sel));
    always #5 sel = ~sel;
    initial
    begin
        sel = 1'b0;
        #5 in = 2'b00;
        #5 in = 2'b01;
        #5 in = 2'b10;
        #5 in = 2'b11;
        #5 in = 2'b00;
        #5 in = 2'b01;
        #5 in = 2'b10;
        #5 in = 2'b11;
        #10 $finish;
    end

    initial
        $monitor("in = %2b, sel = %b, out = %b",in,sel,out);
endmodule
