#!/usr/bin/env python3
"""
RISC-V RV32I 指令集模拟器
"""

import sys
from typing import List, Dict

class RISCVSimulator:
    def __init__(self):
        self.regs = [0] * 32
        self.pc = 0x80000000
        self.memory: Dict[int, int] = {}
        self.instruction_count = 0
        self.max_instructions = 100000
        
    def load_program(self, hex_file: str, base_addr: int = 0x80000000):
        """加载十六进制程序"""
        with open(hex_file, 'r') as f:
            for i, line in enumerate(f):
                addr = base_addr + i * 4
                self.memory[addr] = int(line.strip(), 16)
                
    def read_mem(self, addr: int, size: int = 4) -> int:
        """读取存储器"""
        value = 0
        for i in range(size):
            byte_addr = addr + i
            byte = self.memory.get(byte_addr, 0)
            value |= byte << (i * 8)
        return value
    
    def write_mem(self, addr: int, value: int, size: int = 4):
        """写入存储器"""
        for i in range(size):
            byte_addr = addr + i
            self.memory[byte_addr] = (value >> (i * 8)) & 0xFF
    
    def fetch(self) -> int:
        """取指"""
        return self.memory.get(self.pc, 0)
    
    def decode_execute(self, inst: int):
        """解码并执行指令"""
        opcode = inst & 0x7F
        rd = (inst >> 7) & 0x1F
        funct3 = (inst >> 12) & 0x7
        rs1 = (inst >> 15) & 0x1F
        rs2 = (inst >> 20) & 0x1F
        funct7 = (inst >> 25) & 0x7F
        
        rs1_val = self.regs[rs1]
        rs2_val = self.regs[rs2]
        
        if opcode == 0b0110011:  # R-type
            if funct7 == 0b0000000:
                if funct3 == 0b000:
                    result = (rs1_val + rs2_val) & 0xFFFFFFFF
                elif funct3 == 0b001:
                    result = (rs1_val << (rs2_val & 0x1F)) & 0xFFFFFFFF
                elif funct3 == 0b010:
                    result = 1 if self.to_signed(rs1_val) < self.to_signed(rs2_val) else 0
                elif funct3 == 0b011:
                    result = 1 if rs1_val < rs2_val else 0
                elif funct3 == 0b100:
                    result = rs1_val ^ rs2_val
                elif funct3 == 0b101:
                    result = rs1_val >> (rs2_val & 0x1F)
                elif funct3 == 0b110:
                    result = rs1_val | rs2_val
                elif funct3 == 0b111:
                    result = rs1_val & rs2_val
            elif funct7 == 0b0100000:
                if funct3 == 0b000:
                    result = (rs1_val - rs2_val) & 0xFFFFFFFF
                elif funct3 == 0b101:
                    result = self.to_unsigned(self.to_signed(rs1_val) >> (rs2_val & 0x1F))
            if rd != 0:
                self.regs[rd] = result
                
        elif opcode == 0b0010011:  # I-type ALU
            imm = self.sign_extend(inst >> 20, 12)
            shamt = rs2_val & 0x1F
            
            if funct3 == 0b000:
                result = (rs1_val + imm) & 0xFFFFFFFF
            elif funct3 == 0b010:
                result = 1 if self.to_signed(rs1_val) < imm else 0
            elif funct3 == 0b011:
                result = 1 if rs1_val < self.to_unsigned(imm) else 0
            elif funct3 == 0b100:
                result = rs1_val ^ imm
            elif funct3 == 0b110:
                result = rs1_val | imm
            elif funct3 == 0b111:
                result = rs1_val & imm
            elif funct3 == 0b001 and funct7 == 0b0000000:
                result = (rs1_val << shamt) & 0xFFFFFFFF
            elif funct3 == 0b101 and funct7 == 0b0000000:
                result = rs1_val >> shamt
            elif funct3 == 0b101 and funct7 == 0b0100000:
                result = self.to_unsigned(self.to_signed(rs1_val) >> shamt)
                
            if rd != 0:
                self.regs[rd] = result
                
        elif opcode == 0b0110111:  # LUI
            imm = inst & 0xFFFFF000
            if rd != 0:
                self.regs[rd] = imm
                
        elif opcode == 0b0010111:  # AUIPC
            imm = inst & 0xFFFFF000
            if rd != 0:
                self.regs[rd] = (self.pc + imm) & 0xFFFFFFFF
                
        elif opcode == 0b1101111:  # JAL
            imm = self.decode_j_imm(inst)
            if rd != 0:
                self.regs[rd] = (self.pc + 4) & 0xFFFFFFFF
            self.pc = (self.pc + imm) & 0xFFFFFFFF
            return
            
        elif opcode == 0b1100111:  # JALR
            imm = self.sign_extend(inst >> 20, 12)
            target = (rs1_val + imm) & ~1
            if rd != 0:
                self.regs[rd] = (self.pc + 4) & 0xFFFFFFFF
            self.pc = target & 0xFFFFFFFF
            return
            
        elif opcode == 0b1100011:  # Branch
            imm = self.decode_b_imm(inst)
            taken = False
            if funct3 == 0b000:
                taken = rs1_val == rs2_val
            elif funct3 == 0b001:
                taken = rs1_val != rs2_val
            elif funct3 == 0b100:
                taken = self.to_signed(rs1_val) < self.to_signed(rs2_val)
            elif funct3 == 0b101:
                taken = self.to_signed(rs1_val) >= self.to_signed(rs2_val)
            elif funct3 == 0b110:
                taken = rs1_val < rs2_val
            elif funct3 == 0b111:
                taken = rs1_val >= rs2_val
                
            if taken:
                self.pc = (self.pc + imm) & 0xFFFFFFFF
                return
                
        elif opcode == 0b0000011:  # Load
            imm = self.sign_extend(inst >> 20, 12)
            addr = (rs1_val + imm) & 0xFFFFFFFF
            if funct3 == 0b000:
                value = self.sign_extend(self.read_mem(addr, 1), 8)
            elif funct3 == 0b001:
                value = self.sign_extend(self.read_mem(addr, 2), 16)
            elif funct3 == 0b010:
                value = self.read_mem(addr, 4)
            elif funct3 == 0b100:
                value = self.read_mem(addr, 1)
            elif funct3 == 0b101:
                value = self.read_mem(addr, 2)
            if rd != 0:
                self.regs[rd] = value & 0xFFFFFFFF
                
        elif opcode == 0b0100011:  # Store
            imm = ((inst >> 25) << 5) | ((inst >> 7) & 0x1F)
            imm = self.sign_extend(imm, 12)
            addr = (rs1_val + imm) & 0xFFFFFFFF
            if funct3 == 0b000:
                self.write_mem(addr, rs2_val & 0xFF, 1)
            elif funct3 == 0b001:
                self.write_mem(addr, rs2_val & 0xFFFF, 2)
            elif funct3 == 0b010:
                self.write_mem(addr, rs2_val, 4)
        
        self.pc = (self.pc + 4) & 0xFFFFFFFF
    
    def sign_extend(self, value: int, bits: int) -> int:
        """符号扩展"""
        sign_bit = 1 << (bits - 1)
        return (value & (sign_bit - 1)) - (value & sign_bit)
    
    def to_signed(self, value: int) -> int:
        """转换为有符号数"""
        return value if value < 0x80000000 else value - 0x100000000
    
    def to_unsigned(self, value: int) -> int:
        """转换为无符号数"""
        return value & 0xFFFFFFFF
    
    def decode_b_imm(self, inst: int) -> int:
        """解码B-type立即数"""
        imm = ((inst >> 31) << 12) | \
              (((inst >> 7) & 1) << 11) | \
              (((inst >> 25) & 0x3F) << 5) | \
              (((inst >> 8) & 0xF) << 1)
        return self.sign_extend(imm, 13)
    
    def decode_j_imm(self, inst: int) -> int:
        """解码J-type立即数"""
        imm = ((inst >> 31) << 20) | \
              (((inst >> 12) & 0xFF) << 12) | \
              (((inst >> 20) & 1) << 11) | \
              (((inst >> 21) & 0x3FF) << 1)
        return self.sign_extend(imm, 21)
    
    def run(self, max_steps: int = None, trace: bool = False):
        """运行程序"""
        if max_steps:
            self.max_instructions = max_steps
            
        while self.instruction_count < self.max_instructions:
            inst = self.fetch()
            
            if inst == 0x00000000:
                print("Encountered null instruction, halting.")
                break
                
            if trace:
                self.dump_state()
                
            self.decode_execute(inst)
            self.instruction_count += 1
            
            if self.regs[28] == 1:
                print(f"Test passed! (x28 == 1)")
                break
            if self.regs[28] == 2:
                print(f"Test failed! (x28 == 2)")
                break
                
        print(f"Executed {self.instruction_count} instructions")
        self.dump_state()
    
    def dump_state(self):
        """打印寄存器状态"""
        print(f"PC: 0x{self.pc:08x}")
        for i in range(0, 32, 4):
            regs = [f"x{j:2d}=0x{self.regs[j]:08x}" for j in range(i, min(i+4, 32))]
            print("  ".join(regs))

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: simulator.py <program.hex> [max_steps] [--trace]")
        sys.exit(1)
        
    sim = RISCVSimulator()
    sim.load_program(sys.argv[1])
    
    max_steps = None
    trace = False
    
    for arg in sys.argv[2:]:
        if arg == '--trace':
            trace = True
        else:
            max_steps = int(arg)
    
    sim.run(max_steps, trace)
