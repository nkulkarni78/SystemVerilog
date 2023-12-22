//Below code is for 4-bit dff with active low asynchronous reset

module dff(d_intf dintf);
    always_ff@(posedge dintf.clock, negedge dintf.reset)
    begin
        if(!dintf.reset)
            dintf.q <= 4'b0;
        else
            dintf.q <= dintf.d;
    end
endmodule
