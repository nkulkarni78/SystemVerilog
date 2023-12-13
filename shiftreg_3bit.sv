module shiftreg_3bit(
    input clk, reset,
    input d,
    output logic [2:0]q);

    always@(posedge clk)
    begin
        if(!reset)
            q = 3'b000;
        else
        begin
            q[2]<=q[1];
            q[1]<=q[0];
            q[0]<=d;
        end
    end
endmodule
