package riscv

import chisel3._

object Config {
  val XLEN = 32
  val ADDR_WIDTH = 32
  
  object Opcodes {
    val OP_IMM = "b0010011".U(7.W)
    val OP     = "b0110011".U(7.W)
    val LUI    = "b0110111".U(7.W)
    val AUIPC  = "b0010111".U(7.W)
    val JAL    = "b1101111".U(7.W)
    val JALR   = "b1100111".U(7.W)
    val BRANCH = "b1100011".U(7.W)
    val LOAD   = "b0000011".U(7.W)
    val STORE  = "b0100011".U(7.W)
  }
  
  object AluOp {
    val ADD  = "b0000".U(4.W)
    val SUB  = "b0001".U(4.W)
    val AND  = "b0010".U(4.W)
    val OR   = "b0011".U(4.W)
    val XOR  = "b0100".U(4.W)
    val SLL  = "b0101".U(4.W)
    val SRL  = "b0110".U(4.W)
    val SRA  = "b0111".U(4.W)
    val SLT  = "b1000".U(4.W)
    val SLTU = "b1001".U(4.W)
  }
}
