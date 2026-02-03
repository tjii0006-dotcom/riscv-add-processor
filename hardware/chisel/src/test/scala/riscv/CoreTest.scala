package riscv

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class CoreTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "RISC-V Core"
  
  it should "execute ADDI correctly" in {
    test(new Core).withAnnotations(Seq(WriteVcdAnnotation)) { c =>
      val prog = Seq(
        0x00500093,
        0x00308113
      )
      
      for ((inst, i) <- prog.zipWithIndex) {
        c.io.instrData.poke(inst.U)
        c.clock.step(1)
      }
      
      c.io.pcDebug.expect("h80000008".U)
    }
  }
  
  it should "execute ADD correctly" in {
    test(new Core).withAnnotations(Seq(WriteVcdAnnotation)) { c =>
      val prog = Seq(
        0x00a00093,
        0x01400113,
        0x002081b3
      )
      
      for (inst <- prog) {
        c.io.instrData.poke(inst.U)
        c.clock.step(1)
      }
      
      c.io.pcDebug.expect("h8000000c".U)
    }
  }
  
  it should "execute LUI correctly" in {
    test(new Core).withAnnotations(Seq(WriteVcdAnnotation)) { c =>
      val inst = 0x123450b7
      
      c.io.instrData.poke(inst.U)
      c.clock.step(1)
      
      c.io.pcDebug.expect("h80000004".U)
    }
  }
}
