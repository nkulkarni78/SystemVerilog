module dff(d,q,clk,reset);
    input d;
    input clk,reset;
    output reg q;
    always@(posedge clk)
    begin
        if(!reset)
            q <= 0;
        else
            q <= d;
    end
endmodule
