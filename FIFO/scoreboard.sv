class scoreboard;
  mailbox #(transaction) sco_mbx;
  transaction tr_obj;
  event next;
  bit [7:0] data_in[$];
  bit [7:0] temp;
  int err = 0;
  
  function new(mailbox #(transaction) sco_mbx);
    this.sco_mbx = sco_mbx;
  endfunction
  
  task run();
    forever
      begin
        sco_mbx.get(tr_obj);
        $display("[Time: %0t] [Scoreboard] Write_enable: %0d, Read_enable: %0d, data_in: %0d, data_out: %0d, FIFO_full: %0d, FIFO_empty: %0d", $time,  tr_obj.write_en,  tr_obj.read_en, tr_obj.data_in, tr_obj.data_out, tr_obj.fifo_full, tr_obj.fifo_empty);
        
        if(tr_obj.write_en == 1) begin
          if(tr_obj.fifo_full == 0) begin
            data_in.push_front(tr_obj.data_in);
            $display("[Time: %0t] [Scoreboard] Data is stored in queue. Data: %0d", $time, tr_obj.data_in);
          end
          else begin
            $display("[Time: %0t] [Scoreboard] FIFO is full", $time);
          end
          $display("---------------------------------------------");
        end
        
        if(tr_obj.read_en == 1) begin
          if(tr_obj.fifo_empty == 0) begin
            temp = data_in.pop_back();
            if(temp == tr_obj.data_out)
              $display("[Time: %0t] [Scoreboard] DATA MATCHED", $time);
            else begin
              $display("[Time: %0t] [Scoreboard] DATA MIS MATCHED", $time);
              err++;
            end
          end
          else begin
            $display("[Time: %0t] [Scoreboard] FIFO is empty", $time);
          end
          $display("---------------------------------------------");
        end
        ->next;
      end
  endtask
endclass: scoreboard
