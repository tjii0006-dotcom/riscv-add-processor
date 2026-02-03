package riscv

import chisel3._
import chisel3.util._
import Config.Opcodes
import Config.AluOp

class Control extends Module {
  val io = IO(new Bundle {
    val opcode = Input(UInt(7.W))
    val funct3 = Input(UInt(3.W))
    val funct7 = Input(UInt(7.W))
    val signals = Output(new ControlSignals)
  })
  
  // 默认控制信号
  val defaultSignals = Wire(new ControlSignals)
  defaultSignals.regWrite := false.B
  defaultSignals.memRead  := false.B
  defaultSignals.memWrite := false.B
  defaultSignals.memToReg := false.B
  defaultSignals.aluSrc   := false.B
  defaultSignals.branch   := false.B
  defaultSignals.jump     := false.B
  defaultSignals.aluOp    := AluOp.ADD
  
  // 指令译码逻辑
  io.signals := MuxCase(defaultSignals, Seq(
    // R-type指令（add, sub, and, or, xor, sll, srl, sra, slt, sltu）
    (io.opcode === Opcodes.OP) -> {
      val sig = Wire(new ControlSignals)
      sig := defaultSignals
      sig.regWrite := true.B
      sig.aluOp := MuxCase(AluOp.ADD, Seq(
        (io.funct3 === 0.U && io.funct7(5) === 0.U) -> AluOp.ADD,
        (io.funct3 === 0.U && io.funct7(5) === 1.U) -> AluOp.SUB,
        (io.funct3 === 1.U) -> AluOp.SLL,
        (io.funct3 === 2.U) -> AluOp.SLT,
        (io.funct3 === 3.U) -> AluOp.SLTU,
        (io.funct3 === 4.U) -> AluOp.XOR,
        (io.funct3 === 5.U && io.funct7(5) === 0.U) -> AluOp.SRL,
        (io.funct3 === 5.U && io.funct7(5) === 1.U) -> AluOp.SRA,
        (io.funct3 === 6.U) -> AluOp.OR,
        (io.funct3 === 7.U) -> AluOp.AND
      ))
      sig
    },
    
    // I-type算术指令（addi, slti, sltiu, xori, ori, andi, slli, srli, srai）
    (io.opcode === Opcodes.OP_IMM) -> {
      val sig = Wire(new ControlSignals)
      sig := defaultSignals
      sig.regWrite := true.B
      sig.aluSrc   := true.B  // 使用立即数
      sig.aluOp := MuxCase(AluOp.ADD, Seq(
        (io.funct3 === 0.U) -> AluOp.ADD,
        (io.funct3 === 1.U) -> AluOp.SLL,
        (io.funct3 === 2.U) -> AluOp.SLT,
        (io.funct3 === 3.U) -> AluOp.SLTU,
        (io.funct3 === 4.U) -> AluOp.XOR,
        (io.funct3 === 5.U && io.funct7(5) === 0.U) -> AluOp.SRL,
        (io.funct3 === 5.U && io.funct7(5) === 1.U) -> AluOp.SRA,
        (io.funct3 === 6.U) -> AluOp.OR,
        (io.funct3 === 7.U) -> AluOp.AND
      ))
      sig
    },
    
    // LUI指令
    (io.opcode === Opcodes.LUI) -> {
      val sig = Wire(new ControlSignals)
      sig := defaultSignals
      sig.regWrite := true.B
      sig.aluSrc   := true.B
      sig
    },
    
    // AUIPC指令
    (io.opcode === Opcodes.AUIPC) -> {
      val sig = Wire(new ControlSignals)
      sig := defaultSignals
      sig.regWrite := true.B
      sig.aluSrc   := true.B
      sig
    },
    
    // JAL指令
    (io.opcode === Opcodes.JAL) -> {
      val sig = Wire(new ControlSignals)
      sig := defaultSignals
      sig.regWrite := true.B
      sig.jump     := true.B
      sig
    },
    
    // JALR指令
    (io.opcode === Opcodes.JALR) -> {
      val sig = Wire(new ControlSignals)
      sig := defaultSignals
      sig.regWrite := true.B
      sig.aluSrc   := true.B
      sig.jump     := true.B
      sig
    },
    
    // 分支指令（beq, bne, blt, bge, bltu, bgeu）
    (io.opcode === Opcodes.BRANCH) -> {
      val sig = Wire(new ControlSignals)
      sig := defaultSignals
      sig.branch := true.B
      sig
    },
    
    // 加载指令（lb, lh, lw, lbu, lhu）
    (io.opcode === Opcodes.LOAD) -> {
      val sig = Wire(new ControlSignals)
      sig := defaultSignals
      sig.regWrite := true.B
      sig.memRead  := true.B
      sig.memToReg := true.B
      sig.aluSrc   := true.B
      sig
    },
    
    // 存储指令（sb, sh, sw）
    (io.opcode === Opcodes.STORE) -> {
      val sig = Wire(new ControlSignals)
      sig := defaultSignals
      sig.memWrite := true.B
      sig.aluSrc   := true.B
      sig
    }
  ))
}
