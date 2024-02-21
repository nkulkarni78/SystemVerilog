compile:
	vcs -sverilog -full64 mem_interface.sv memory.sv transaction.sv \
	generator.sv driver.sv monitor.sv scoreboard.sv env.sv top.sv

sim:
	./simv

report:
	urg -full64 -dir simv.vdb -format both

clean:
	rm -rf simv* csrc ucli.key report urgReport
