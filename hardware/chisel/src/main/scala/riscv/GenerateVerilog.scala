package riscv

import chisel3._
import java.io._

object GenerateVerilog extends App {
  // 生成Core的Verilog
  val coreVerilog = (new chisel3.stage.ChiselStage).emitVerilog(new Core)
  
  // 生成Top的Verilog
  val topVerilog = (new chisel3.stage.ChiselStage).emitVerilog(new Top())
  
  // 创建输出目录
  val outputDir = new File("generated")
  outputDir.mkdirs()
  
  // 写入文件
  val coreFile = new FileWriter(new File(outputDir, "Core.v"))
  coreFile.write(coreVerilog)
  coreFile.close()
  
  val topFile = new FileWriter(new File(outputDir, "Top.v"))
  topFile.write(topVerilog)
  topFile.close()
  
  println(s"Verilog files generated in ${outputDir.getAbsolutePath}/")
  println("  - Core.v")
  println("  - Top.v")
}
