//Below code is for 4-bit dff with active low asynchronous reset

module dff(d,q,clk,reset);
    input [3:0]d;
    input clk,reset;
    output reg [3:0]q;
    always_ff@(posedge clk, negedge reset)
    begin
        if(!reset)
            q <= 4'b0;
        else
            q <= d;
    end
endmodule
