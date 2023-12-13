module mux2x1t(in,out,sel);
    input [1:0]in;
    input sel;
    output reg out;
    always@(sel or in)
    begin
        out = (sel == 0)?in[0]:in[1];
    end
endmodule
