//Self checking testbench program block for 4-bit asynchronous D-ff.

program dff_tb(tb_clk,tb_reset,tb_d,tb_q);
    // port variable declaration
    output logic tb_reset;
    output logic [3:0]tb_d;
    input logic [3:0]tb_q;
    input tb_clk;

    // queues to track actual and reference values
    reg [3:0]d_exp[$];
    reg [3:0]d_act[$];

    reg [3:0] temp = 4'b0;

    // variables to count passing and failing vectors
    int unsigned matched;
    int unsigned mismatched;

    // initial reset conditions
    initial
    begin
        tb_reset = 1'b1;
        #3 tb_reset = 1'b0;
        #3 tb_reset = 1'b1;
    end

    // stimulus and golden reflog tracking
    initial
    begin
         #4 tb_d = 4'b0000;
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
       
        #5
        // results comparison
        for(int i=0; i<d_exp.size(); i++)
        begin
            if(d_act[i] == d_exp[i])
            begin 
                matched++;
                $display("[Info] MATCHED: Expected = %d Received = %d", d_exp[i],d_act[i]);
            end
            else
            begin
                mismatched++;
                $display("[Error] MISMATCHED: Expected = %d Received = %d", d_exp[i],d_act[i]);
            end
        end
        #20 $finish;
    end

    // actual outcome from DUT
    initial
    begin
        forever@(tb_q)
        begin
            // giving a time delay is avoiding 'x' while monitoring output
            #2
            temp = tb_q;
            d_act.push_back(temp);
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
endprogram
