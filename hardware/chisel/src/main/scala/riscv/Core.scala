package riscv

import chisel3._
import chisel3.util._

class CoreIO extends Bundle {
  val instrAddr = Output(UInt(32.W))
  val instrData = Input(UInt(32.W))
  
  val dataAddr   = Output(UInt(32.W))
  val dataWrite  = Output(UInt(32.W))
  val dataRead   = Input(UInt(32.W))
  val dataWen    = Output(Bool())
  val dataRen    = Output(Bool())
  val dataMask   = Output(UInt(4.W))
  
  val pcDebug  = Output(UInt(32.W))
}

class Core extends Module {
  val io = IO(new CoreIO)
  
  val datapath = Wire(new DataPath)
  
  val pcReg = RegInit(0x80000000L.U(32.W))
  datapath.pc := pcReg
  
  io.instrAddr := datapath.pc
  datapath.instr.bits := io.instrData
  
  val control = Module(new Control)
  control.io.opcode := datapath.instr.opcode
  control.io.funct3 := datapath.instr.funct3
  control.io.funct7 := datapath.instr.funct7
  
  val regFile = Module(new RegFile)
  regFile.io.readAddr1 := datapath.instr.rs1
  regFile.io.readAddr2 := datapath.instr.rs2
  datapath.regRead1 := regFile.io.readData1
  datapath.regRead2 := regFile.io.readData2
  
  val alu = Module(new Alu)
  alu.io.op := control.io.signals.aluOp
  
  val aluIn1 = MuxCase(datapath.regRead1, Seq(
    (datapath.instr.opcode === Config.Opcodes.AUIPC) -> datapath.pc
  ))
  
  val aluIn2 = Mux(control.io.signals.aluSrc,
    datapath.instr.i_imm.asUInt,
    datapath.regRead2
  )
  
  val finalAluIn2 = Mux(datapath.instr.opcode === Config.Opcodes.LUI,
    datapath.instr.u_imm.asUInt,
    aluIn2
  )
  
  alu.io.in1 := aluIn1
  alu.io.in2 := finalAluIn2
  datapath.aluResult := alu.io.out
  
  io.dataAddr  := datapath.aluResult
  io.dataWrite := datapath.regRead2
  io.dataWen   := control.io.signals.memWrite
  io.dataRen   := control.io.signals.memRead
  io.dataMask  := 0xF.U
  
  datapath.memData := io.dataRead
  
  datapath.regWriteData := Mux(control.io.signals.memToReg, 
    datapath.memData, 
    Mux(control.io.signals.jump,
      (datapath.pc + 4.U),
      datapath.aluResult
    )
  )
  datapath.regWriteAddr := datapath.instr.rd
  
  regFile.io.writeAddr := datapath.regWriteAddr
  regFile.io.writeData := datapath.regWriteData
  regFile.io.writeEn   := control.io.signals.regWrite
  
  val branchTarget = datapath.pc + datapath.instr.b_imm.asUInt
  val jumpTarget = Mux(
    datapath.instr.opcode === Config.Opcodes.JALR,
    (datapath.regRead1 + datapath.instr.i_imm.asUInt) & ~1.U(32.W),
    datapath.pc + datapath.instr.j_imm.asUInt
  )
  
  val nextPc = MuxCase(datapath.pc + 4.U, Seq(
    (control.io.signals.jump) -> jumpTarget,
    (control.io.signals.branch && alu.io.zero) -> branchTarget
  ))
  
  pcReg := nextPc
  datapath.nextPc := nextPc
  
  io.pcDebug := datapath.pc
}
