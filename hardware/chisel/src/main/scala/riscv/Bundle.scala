package riscv

import chisel3._
import chisel3.util._

class Instruction extends Bundle {
  val bits = UInt(32.W)
  
  def opcode = bits(6, 0)
  def rd     = bits(11, 7)
  def rs1    = bits(19, 15)
  def rs2    = bits(24, 20)
  def funct3 = bits(14, 12)
  def funct7 = bits(31, 25)
  
  def i_imm = Cat(Fill(20, bits(31)), bits(31, 20)).asSInt
  def s_imm = Cat(Fill(20, bits(31)), bits(31, 25), bits(11, 7)).asSInt
  def b_imm = Cat(Fill(19, bits(31)), bits(31), bits(7), bits(30, 25), bits(11, 8), 0.U(1.W)).asSInt
  def u_imm = Cat(bits(31, 12), Fill(12, 0.U)).asSInt
  def j_imm = Cat(Fill(11, bits(31)), bits(31), bits(19, 12), bits(20), bits(30, 21), 0.U(1.W)).asSInt
}

class ControlSignals extends Bundle {
  val regWrite  = Bool()
  val memRead   = Bool()
  val memWrite  = Bool()
  val memToReg  = Bool()
  val aluSrc    = Bool()
  val branch    = Bool()
  val jump      = Bool()
  val aluOp     = UInt(4.W)
}

class DataPath extends Bundle {
  val pc        = UInt(32.W)
  val instr     = new Instruction
  val regRead1  = UInt(32.W)
  val regRead2  = UInt(32.W)
  val aluResult = UInt(32.W)
  val memData   = UInt(32.W)
  val regWriteData = UInt(32.W)
  val regWriteAddr = UInt(5.W)
  val nextPc    = UInt(32.W)
}
