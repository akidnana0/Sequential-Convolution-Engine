RTL     = rtl/conv2d_engine.v
TB      = tb/tb_conv2d.v
TOP     = tb_conv2d
SIM_DIR = sim

.PHONY: all compile sim wave golden lint clean

all: sim

compile:
	mkdir -p $(SIM_DIR)
	iverilog -g2012 -Wall -s $(TOP) -o $(SIM_DIR)/$(TOP).vvp $(RTL) $(TB)

sim: compile
	cd $(SIM_DIR) && vvp $(TOP).vvp

wave:
	gtkwave $(SIM_DIR)/$(TOP).vcd &

golden:
	python3 scripts/golden_model.py

lint:
	verilator --lint-only -Wall $(RTL)

clean:
	rm -rf $(SIM_DIR)