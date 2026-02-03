# RISC-V加法处理器项目

基于Chisel和Verilog的RISC-V RV32I处理器实现，专注于算术和逻辑运算。

## 项目结构
riscv-add-processor/
├── hardware/
│   ├── chisel/          # Chisel高级综合代码
│   ├── verilog/         # Verilog实现
│   └── scripts/         # 综合脚本
├── software/
│   ├── assembler/       # Python汇编器
│   ├── simulator/       # 指令集模拟器
│   └── tests/           # 测试程序
├── toolchain/           # 工具链配置
└── docs/               # 文档

## 快速开始

### 环境要求

- Ubuntu 20.04/22.04
- Java 11+
- Scala & SBT
- Python 3.8+
- Verilator/Icarus Verilog
