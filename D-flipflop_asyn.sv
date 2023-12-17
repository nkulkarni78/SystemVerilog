//Below code is for 1-bit dff with active low asynchronous reset

module dff(d,q,clk,reset);
    input d;
    input clk,reset;
    output reg q;
    always_ff@(posedge clk, negedge reset)
    begin
        if(!reset)
            q <= 0;
        else
            q <= d;
    end
endmodule
