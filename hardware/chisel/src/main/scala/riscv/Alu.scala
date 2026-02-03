package riscv

import chisel3._
import chisel3.util._
import Config.AluOp

class Alu extends Module {
  val io = IO(new Bundle {
    val op    = Input(UInt(4.W))    // 操作码
    val in1   = Input(UInt(32.W))   // 操作数1
    val in2   = Input(UInt(32.W))   // 操作数2
    val out   = Output(UInt(32.W))  // 结果
    val zero  = Output(Bool())      // 结果为零标志
  })
  
  // 移位量（只取低5位）
  val shamt = io.in2(4, 0)
  
  // ALU运算逻辑
  io.out := MuxCase(0.U, Seq(
    (io.op === AluOp.ADD)  -> (io.in1 + io.in2),
    (io.op === AluOp.SUB)  -> (io.in1 - io.in2),
    (io.op === AluOp.AND)  -> (io.in1 & io.in2),
    (io.op === AluOp.OR)   -> (io.in1 | io.in2),
    (io.op === AluOp.XOR)  -> (io.in1 ^ io.in2),
    (io.op === AluOp.SLL)  -> (io.in1 << shamt),
    (io.op === AluOp.SRL)  -> (io.in1 >> shamt),
    (io.op === AluOp.SRA)  -> (io.in1.asSInt >> shamt).asUInt,
    (io.op === AluOp.SLT)  -> (io.in1.asSInt < io.in2.asSInt).asUInt,
    (io.op === AluOp.SLTU) -> (io.in1 < io.in2).asUInt
  ))
  
  // 零标志
  io.zero := (io.out === 0.U)
}
