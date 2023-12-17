//Self checking testbench for 1-bit asynchronous D-ff

module test;
    // port variable declaration
    logic tb_clk,tb_reset;
    logic tb_d;
    logic tb_q;

    // queues to track actual and reference values
    reg d_exp[$];
    reg d_act[$];

    // DUT instantiation
    dff d1(.clk(tb_clk),.reset(tb_reset),.d(tb_d),.q(tb_q));

    // clock instantiation
    always #5 tb_clk = ~tb_clk;

    // variables to count passing and failing vectors
    int unsigned matched;
    int unsigned mismatched;

    // initial reset conditions
    initial
    begin
        tb_clk = 1'b0;
        tb_reset = 1'b1;
        #5 tb_reset = 1'b0;
        #5 tb_reset = 1'b1;
    end

    // stimulus and golden reflog tracking
    initial
    begin
        #5 tb_d = 1'b0;
        d_exp.push_back(tb_d);
        #10 tb_d = 1'b1;
        d_exp.push_back(tb_d);
        #10 tb_d = 1'b1;
        d_exp.push_back(tb_d);
        #10 tb_d = 1'b1;
        d_exp.push_back(tb_d);
        #10 tb_d = 1'b0;
        d_exp.push_back(tb_d);
        #10 tb_d = 1'b0;
        d_exp.push_back(tb_d);
       
        #10
        // results comparison
        for(int i=0; i<d_exp.size(); i++)
        begin
            if(d_act[i] == d_exp[i])
            begin 
                matched++;
                $display("[Info] MATCHED: Expected = %0b Received = %0b",d_exp[i],d_act[i]);
            end
            else
            begin
                mismatched++;
                $display("[Error] MISMATCHED: Expected = %0b Received = %0b",d_exp[i],d_act[i]);
            end
        end
        #20 $finish;
    end



    // actual outcome from DUT
    initial
    begin
        $dumpfile("dff.vcd");
        $dumpvars(0,test.d1);
        forever @(posedge tb_clk)
        begin
            #1
            d_act.push_back(tb_q);
        end
    end

    // final triggered whenever $finish is observed
    final
    begin
        $display("Matched: %0d",matched);
        $display("Mis-Matched: %0d",mismatched);
        if(matched == d_exp.size())
            $display("TEST PASSED");
        else

            $display("TEST FAILED");
    end

endmodule
