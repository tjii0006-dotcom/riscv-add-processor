package riscv

import chisel3._
import chisel3.util._

// 32个通用寄存器，x0硬连线为0
class RegFile extends Module {
  val io = IO(new Bundle {
    // 读端口（异步读）
    val readAddr1 = Input(UInt(5.W))
    val readAddr2 = Input(UInt(5.W))
    val readData1 = Output(UInt(32.W))
    val readData2 = Output(UInt(32.W))
    
    // 写端口（同步写）
    val writeAddr = Input(UInt(5.W))
    val writeData = Input(UInt(32.W))
    val writeEn   = Input(Bool())
  })
  
  // 32个32位寄存器，初始化为0
  val regs = RegInit(VecInit(Seq.fill(32)(0.U(32.W))))
  
  // 读逻辑：x0恒为0，其他读取寄存器值
  io.readData1 := Mux(io.readAddr1 === 0.U, 0.U, regs(io.readAddr1))
  io.readData2 := Mux(io.readAddr2 === 0.U, 0.U, regs(io.readAddr2))
  
  // 写逻辑：写使能且不是x0时写入
  when(io.writeEn && io.writeAddr =/= 0.U) {
    regs(io.writeAddr) := io.writeData
  }
}
