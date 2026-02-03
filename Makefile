PROJECT_NAME = riscv-add-processor
ROOT_DIR = $(shell pwd)

HW_DIR = $(ROOT_DIR)/hardware
SW_DIR = $(ROOT_DIR)/software
CHISEL_DIR = $(HW_DIR)/chisel
VERILOG_DIR = $(HW_DIR)/verilog

SBT = sbt
PYTHON = python3
IVERILOG = iverilog
VVP = vvp

.PHONY: all clean test sim hardware software

all: hardware software

hardware: chisel

chisel:
	@echo "=== Generating Verilog from Chisel ==="
	cd $(CHISEL_DIR) && $(SBT) "runMain riscv.GenerateVerilog"

verilog: $(VERILOG_DIR)/core/riscv_core.v

sim-verilog: $(VERILOG_DIR)/testbench/tb_core.v $(VERILOG_DIR)/core/riscv_core.v
	@echo "=== Running Verilog simulation ==="
	cd $(VERILOG_DIR) && $(IVERILOG) -o sim.vvp testbench/tb_core.v core/riscv_core.v
	cd $(VERILOG_DIR) && $(VVP) sim.vvp

software: assembler simulator tests

assembler: $(SW_DIR)/assembler/assembler.py
	@echo "=== Assembler ready ==="
	chmod +x $(SW_DIR)/assembler/assembler.py

simulator: $(SW_DIR)/simulator/simulator.py
	@echo "=== Simulator ready ==="
	chmod +x $(SW_DIR)/simulator/simulator.py

tests: assembler
	@echo "=== Assembling test programs ==="
	mkdir -p $(SW_DIR)/tests/build
	$(PYTHON) $(SW_DIR)/assembler/assembler.py \
		$(SW_DIR)/tests/test_add.asm \
		$(SW_DIR)/tests/build/test_add.hex
	$(PYTHON) $(SW_DIR)/assembler/assembler.py \
		$(SW_DIR)/tests/test_branch.asm \
		$(SW_DIR)/tests/build/test_branch.hex

sim-sw: tests simulator
	@echo "=== Running software simulation ==="
	$(PYTHON) $(SW_DIR)/simulator/simulator.py \
		$(SW_DIR)/tests/build/test_add.hex --trace

test-chisel:
	@echo "=== Running Chisel tests ==="
	cd $(CHISEL_DIR) && $(SBT) test

waveform:
	@echo "=== Generating VCD waveforms ==="
	cd $(CHISEL_DIR) && $(SBT) "testOnly riscv.CoreTest"

fpga: chisel
	@echo "=== Preparing FPGA files ==="
	mkdir -p $(HW_DIR)/fpga
	cp $(CHISEL_DIR)/generated/*.v $(HW_DIR)/fpga/ 2>/dev/null || \
	cp $(VERILOG_DIR)/core/*.v $(HW_DIR)/fpga/

clean:
	@echo "=== Cleaning build artifacts ==="
	cd $(CHISEL_DIR) && $(SBT) clean 2>/dev/null || true
	rm -rf $(CHISEL_DIR)/target
	rm -rf $(CHISEL_DIR)/project/target
	rm -rf $(CHISEL_DIR)/generated
	rm -rf $(SW_DIR)/tests/build
	rm -rf $(HW_DIR)/fpga
	rm -f $(VERILOG_DIR)/*.vvp $(VERILOG_DIR)/*.vcd
	find . -name "*.vcd" -delete
	@echo "Clean complete"

help:
	@echo "RISC-V加法处理器项目"
	@echo ""
	@echo "可用目标:"
	@echo "  make all          - 构建所有内容"
	@echo "  make hardware     - 生成硬件(Chisel->Verilog)"
	@echo "  make software     - 准备软件工具"
	@echo "  make tests        - 汇编测试程序"
	@echo "  make test-chisel  - 运行Chisel单元测试"
	@echo "  make sim-verilog  - 运行Verilog仿真"
	@echo "  make sim-sw       - 运行软件模拟器"
	@echo "  make waveform     - 生成VCD波形文件"
	@echo "  make fpga         - 准备FPGA综合文件"
	@echo "  make clean        - 清理构建文件"
