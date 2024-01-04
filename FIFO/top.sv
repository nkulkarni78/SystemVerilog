module top;
  reg top_clock, top_reset, top_read_en, top_write_en, top_fifo_full;
  reg top_fifo_empty;
  reg [7:0] top_data_in, top_data_outp;
  
  initial top_clock = 1'b0;

  always #5 top_clock = ~top_clock;

  fifo dut_inst(.clock(top_clock),
                .reset(top_reset),
                .read_en(top_read_en),
                .write_en(top_write_en),
                .data_in(top_data_in),
                .data_outp(top_data_outp),
                .fifo_full(top_fifo_full),
                .fifo_empty(top_fifo_empty));

  fifo_test test_inst (.tb_clock(top_clock),
                       .tb_reset(top_reset),
                       .tb_read_en(top_read_en),
                       .tb_write_en(top_write_en),
                       .tb_data_in(top_data_in),
                       .tb_data_outp(top_data_outp),
                       .tb_fifo_full(top_fifo_full),
                       .tb_fifo_empty(top_fifo_empty));

endmodule
