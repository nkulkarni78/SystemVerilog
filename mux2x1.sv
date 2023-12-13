module mux2x1if(in,out,sel);
    input [1:0]in;
    input sel;
    output reg out;
    always@(sel or in)
    begin
        if(sel == 1'b0)
            out = in[0];
        else
            out = in[1];
    end
endmodule
