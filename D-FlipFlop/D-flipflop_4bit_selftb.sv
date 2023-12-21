//Self checking testbench for 1-bit asynchronous D-ff

module test;
    // port variable declaration
    logic tb_clk,tb_reset;
    logic [3:0]tb_d;
    logic [3:0]tb_q;

    // queues to track actual and reference values
    reg [3:0]d_exp[$];
    reg [3:0]d_act[$];

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
        #5 tb_d = 4'b0000;
        d_exp.push_back(tb_d);
        #10 tb_d = 4'b0001;
        d_exp.push_back(tb_d);
        #10 tb_d = 4'b0010;
        d_exp.push_back(tb_d);
        #10 tb_d = 4'b0011;
        d_exp.push_back(tb_d);
        #10 tb_d = 4'b0100;
        d_exp.push_back(tb_d);
        #10 tb_d = 4'b0101;
        d_exp.push_back(tb_d);
        #10 tb_d = 4'b0110;
        d_exp.push_back(tb_d);
        #10 tb_d = 4'b0111;
        d_exp.push_back(tb_d);
        #10 tb_d = 4'b1000;
        d_exp.push_back(tb_d);
        #10 tb_d = 4'b1001;
        d_exp.push_back(tb_d);
        #10 tb_d = 4'b1010;
        d_exp.push_back(tb_d);
        #10 tb_d = 4'b1011;
        d_exp.push_back(tb_d);
        #10 tb_d = 4'b1100;
        d_exp.push_back(tb_d);
        #10 tb_d = 4'b1101;
        d_exp.push_back(tb_d);
        #10 tb_d = 4'b1110;
        d_exp.push_back(tb_d);
        #10 tb_d = 4'b1111;
        d_exp.push_back(tb_d);
       
        #10
        // results comparison
        for(int i=0; i<d_exp.size(); i++)
        begin
            if(d_act[i] == d_exp[i])
            begin 
                matched++;
                $display("[Info] MATCHED: Expected = %d Received = %d",d_exp[i],d_act[i]);
            end
            else
            begin
                mismatched++;
                $display("[Error] MISMATCHED: Expected = %d Received = %d",d_exp[i],d_act[i]);
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
