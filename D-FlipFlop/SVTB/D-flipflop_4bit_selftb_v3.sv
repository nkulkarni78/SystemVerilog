//Self checking testbench program block for 4-bit asynchronous D-ff.

program dff_tb(d_intf vintf);

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
        vintf.reset = 1'b1;
        #3 vintf.reset = 1'b0;
        #3 vintf.reset = 1'b1;
    end

    // stimulus and golden reflog tracking
    initial
    begin
         #4 vintf.d = 4'b0000;
        d_exp.push_back(vintf.d);
        #10 vintf.d = 4'b0001;
        d_exp.push_back(vintf.d);
        #10 vintf.d = 4'b0010;
        d_exp.push_back(vintf.d);
        #10 vintf.d = 4'b0011;
        d_exp.push_back(vintf.d);
        #10 vintf.d = 4'b0100;
        d_exp.push_back(vintf.d);
        #10 vintf.d = 4'b0101;
        d_exp.push_back(vintf.d);
        #10 vintf.d = 4'b0110;
        d_exp.push_back(vintf.d);
        #10 vintf.d = 4'b0111;
        d_exp.push_back(vintf.d);
        #10 vintf.d = 4'b1000;
        d_exp.push_back(vintf.d);
        #10 vintf.d = 4'b1001;
        d_exp.push_back(vintf.d);
        #10 vintf.d = 4'b1010;
        d_exp.push_back(vintf.d);
        #10 vintf.d = 4'b1011;
        d_exp.push_back(vintf.d);
        #10 vintf.d = 4'b1100;
        d_exp.push_back(vintf.d);
        #10 vintf.d = 4'b1101;
        d_exp.push_back(vintf.d);
        #10 vintf.d = 4'b1110;
        d_exp.push_back(vintf.d);
        #10 vintf.d = 4'b1111;
        d_exp.push_back(vintf.d);
       
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
        forever@(vintf.q)
        begin
            // giving a time delay is avoiding 'x' while monitoring output
            #2
            temp = vintf.q;
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
