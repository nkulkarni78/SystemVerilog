program fifo_test(tb_clock, tb_reset, tb_read_en, tb_write_en, tb_data_in,
                  tb_data_outp, tb_fifo_full, tb_fifo_empty);
  // port declarations with respect to directions.
  input [7:0] tb_data_outp;
  input tb_fifo_full, tb_fifo_empty;
  input tb_clock;
  output reg tb_reset;
  output reg [7:0] tb_data_in;
  output reg tb_read_en;
  output reg tb_write_en;
  
  reg [7:0] exp[$];
  reg [7:0] act[$];

  // stimuli generation and self checking with tasks
  initial
  begin
      tb_reset = 1'b1;

    @(negedge tb_clock) begin
      tb_reset = 1'b0;
      tb_read_en = 1'b1;
      tb_write_en = 1'b1;
      tb_data_in = $urandom(45);
      exp.push_back(tb_data_in);
    end

    @(negedge tb_clock);
      exp.push_back(tb_data_in);
      act.push_back(tb_data_outp);

    @(negedge tb_clock);
      $display("TIME: %0t READING DISABLED ",$time);
      tb_read_en = 1'b0;
      exp.push_back(tb_data_in);
    
    @(negedge tb_clock) begin
      tb_data_in = $urandom(54);
      exp.push_back(tb_data_in);
    end

    repeat(5) @(negedge tb_clock) begin
      tb_data_in = $urandom_range(0,255);
      exp.push_back(tb_data_in);
    end

    @(negedge tb_clock) begin
      tb_read_en = 1'b1; 
      tb_write_en = 1'b0;
      $display("TIME: %0t READING ENABLED ",$time);
    end

    repeat(7)@(negedge tb_clock) begin
      act.push_back(tb_data_outp);
    end

    @(negedge tb_clock) begin
      act.push_back(tb_data_outp);
    end
  end

  final 
  begin
    for(int i=0; i<exp.size(); i++) begin
      if(exp[i] == act[i])
        $display("[INFO] DATA MATCHED: expected: %0d, Actual = %0d", exp[i],act[i]);
      else
        $display("[ERROR] DATA MIS-MATCHED: expected: %0d, Actual = %0d", exp[i],act[i]);
    end
  end
endprogram
