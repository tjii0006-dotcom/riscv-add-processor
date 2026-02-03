# RISC-V加法处理器

基于Verilog/chisel的RISC-V RV32I处理器实现，功能主要为算术和逻辑运算

## 项目结构
riscv-add-processor/
├── hardware/
│   ├── chisel/          # Chisel（勉强跑通暂未验证）
│   ├── verilog/         # Verilog版本
│   └── scripts/         # 综合脚本
├── software/
│   ├── assembler/       # Python汇编器
│   ├── simulator/       # 指令集模拟器
│   └── tests/           # 测试程序
├── toolchain/           # 工具链配置
└── docs/               # 文档

顶层里因为部分RV指令集和当时环境不适配，部分手段可能较为粗暴

### 环境要求

- Ubuntu 22.04+
- Java 11+
- Scala & SBT
- Python 3.8+
- Verilator/Icarus Verilog
