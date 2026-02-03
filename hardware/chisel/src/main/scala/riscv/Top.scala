package riscv

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFileInline

class Top(initHexFile: String = "") extends Module {
  val io = IO(new Bundle {
    val halt = Output(Bool())
  })
  
  val core = Module(new Core)
  
  val imem = Mem(1024, UInt(32.W))
  if (initHexFile.nonEmpty) {
    loadMemoryFromFileInline(imem, initHexFile)
  }
  
  val dmem = Mem(1024, UInt(32.W))
  
  val instrAddrIdx = core.io.instrAddr(11, 2)
  core.io.instrData := imem(instrAddrIdx)
  
  val dataAddrIdx = core.io.dataAddr(11, 2)
  core.io.dataRead := dmem(dataAddrIdx)
  
  when(core.io.dataWen) {
    dmem(dataAddrIdx) := core.io.dataWrite
  }
  
  io.halt := core.io.pcDebug >= 0x80001000L.U
}
