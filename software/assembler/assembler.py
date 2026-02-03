#!/usr/bin/env python3
"""
RISC-V RV32I 汇编器 (简化版)
支持: add, sub, and, or, xor, addi, lui, auipc, jal, jalr, beq, bne, lw, sw等
"""

import re
import sys
from typing import Dict, List, Tuple

# 指令编码表
OPCODES = {
    'lui': 0b0110111, 'auipc': 0b0010111, 'jal': 0b1101111,
    'jalr': 0b1100111, 'beq': 0b1100011, 'bne': 0b1100011,
    'blt': 0b1100011, 'bge': 0b1100011, 'bltu': 0b1100011,
    'bgeu': 0b1100011, 'lb': 0b0000011, 'lh': 0b0000011,
    'lw': 0b0000011, 'lbu': 0b0000011, 'lhu': 0b0000011,
    'sb': 0b0100011, 'sh': 0b0100011, 'sw': 0b0100011,
    'addi': 0b0010011, 'slti': 0b0010011, 'sltiu': 0b0010011,
    'xori': 0b0010011, 'ori': 0b0010011, 'andi': 0b0010011,
    'slli': 0b0010011, 'srli': 0b0010011, 'srai': 0b0010011,
    'add': 0b0110011, 'sub': 0b0110011, 'sll': 0b0110011,
    'slt': 0b0110011, 'sltu': 0b0110011, 'xor': 0b0110011,
    'srl': 0b0110011, 'sra': 0b0110011, 'or': 0b0110011,
    'and': 0b0110011,
}

FUNCT3 = {
    'addi': 0b000, 'slti': 0b010, 'sltiu': 0b011,
    'xori': 0b100, 'ori': 0b110, 'andi': 0b111,
    'slli': 0b001, 'srli': 0b101, 'srai': 0b101,
    'add': 0b000, 'sub': 0b000, 'sll': 0b001,
    'slt': 0b010, 'sltu': 0b011, 'xor': 0b100,
    'srl': 0b101, 'sra': 0b101, 'or': 0b110,
    'and': 0b111, 'jalr': 0b000,
    'beq': 0b000, 'bne': 0b001, 'blt': 0b100,
    'bge': 0b101, 'bltu': 0b110, 'bgeu': 0b111,
    'lb': 0b000, 'lh': 0b001, 'lw': 0b010,
    'lbu': 0b100, 'lhu': 0b101,
    'sb': 0b000, 'sh': 0b001, 'sw': 0b010,
}

FUNCT7 = {
    'add': 0b0000000, 'sub': 0b0100000,
    'sll': 0b0000000, 'slt': 0b0000000,
    'sltu': 0b0000000, 'xor': 0b0000000,
    'srl': 0b0000000, 'sra': 0b0100000,
    'or': 0b0000000, 'and': 0b0000000,
    'slli': 0b0000000, 'srli': 0b0000000,
    'srai': 0b0100000,
}

REG_NAMES = {
    'zero': 0, 'ra': 1, 'sp': 2, 'gp': 3, 'tp': 4,
    't0': 5, 't1': 6, 't2': 7, 's0': 8, 'fp': 8,
    's1': 9, 'a0': 10, 'a1': 11, 'a2': 12, 'a3': 13,
    'a4': 14, 'a5': 15, 'a6': 16, 'a7': 17,
    's2': 18, 's3': 19, 's4': 20, 's5': 21,
    's6': 22, 's7': 23, 's8': 24, 's9': 25,
    's10': 26, 's11': 27, 't3': 28, 't4': 29,
    't5': 30, 't6': 31,
}

def parse_reg(r: str) -> int:
    """解析寄存器名或编号"""
    r = r.strip().lower().replace('x', '')
    if r in REG_NAMES:
        return REG_NAMES[r]
    return int(r)

def parse_imm(s: str) -> int:
    """解析立即数"""
    s = s.strip().lower()
    if s.startswith('0x'):
        return int(s, 16)
    elif s.startswith('0b'):
        return int(s, 2)
    else:
        return int(s)

class Assembler:
    def __init__(self):
        self.labels: Dict[str, int] = {}
        self.instructions: List[Tuple[int, str, List[str]]] = []
        self.current_addr = 0
        
    def first_pass(self, lines: List[str]):
        """第一遍：收集标签"""
        for line in lines:
            line = line.strip()
            if not line or line.startswith('#'):
                continue
                
            if ':' in line:
                label, rest = line.split(':', 1)
                self.labels[label.strip()] = self.current_addr
                line = rest.strip()
                if not line:
                    continue
            
            if not line or line.startswith('#'):
                continue
                
            self.instructions.append((self.current_addr, line, []))
            self.current_addr += 4
            
    def second_pass(self) -> List[int]:
        """第二遍：生成机器码"""
        machine_codes = []
        
        for addr, line, _ in self.instructions:
            parts = re.split(r'[\s,]+', line)
            op = parts[0].lower()
            args = [p.strip() for p in parts[1:] if p.strip()]
            
            code = self.encode(op, args, addr)
            machine_codes.append(code)
            
        return machine_codes
    
    def encode(self, op: str, args: List[str], addr: int) -> int:
        """编码单条指令"""
        opcode = OPCODES.get(op, 0)
        
        if op in ['add', 'sub', 'sll', 'slt', 'sltu', 'xor', 'srl', 'sra', 'or', 'and']:
            rd = parse_reg(args[0])
            rs1 = parse_reg(args[1])
            rs2 = parse_reg(args[2])
            funct3 = FUNCT3[op]
            funct7 = FUNCT7[op]
            return (funct7 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
            
        elif op in ['addi', 'slti', 'sltiu', 'xori', 'ori', 'andi']:
            rd = parse_reg(args[0])
            rs1 = parse_reg(args[1])
            imm = parse_imm(args[2]) & 0xFFF
            funct3 = FUNCT3[op]
            return (imm << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
            
        elif op in ['slli', 'srli', 'srai']:
            rd = parse_reg(args[0])
            rs1 = parse_reg(args[1])
            shamt = parse_imm(args[2]) & 0x1F
            funct3 = FUNCT3[op]
            funct7 = FUNCT7[op]
            return (funct7 << 25) | (shamt << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
            
        elif op == 'lui':
            rd = parse_reg(args[0])
            imm = (parse_imm(args[1]) & 0xFFFFF000) >> 12
            return (imm << 12) | (rd << 7) | opcode
            
        elif op == 'auipc':
            rd = parse_reg(args[0])
            imm = (parse_imm(args[1]) & 0xFFFFF000) >> 12
            return (imm << 12) | (rd << 7) | opcode
            
        elif op == 'jalr':
            rd = parse_reg(args[0])
            m = re.match(r'(-?\d+)\s*\(\s*(\w+)\s*\)', args[1])
            if m:
                offset = int(m.group(1)) & 0xFFF
                rs1 = parse_reg(m.group(2))
            else:
                offset = 0
                rs1 = parse_reg(args[1])
            funct3 = 0b000
            return (offset << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
            
        elif op in ['lw', 'lh', 'lb', 'lhu', 'lbu']:
            rd = parse_reg(args[0])
            m = re.match(r'(-?\d+)\s*\(\s*(\w+)\s*\)', args[1])
            offset = int(m.group(1)) & 0xFFF if m else 0
            rs1 = parse_reg(m.group(2)) if m else parse_reg(args[1])
            funct3 = FUNCT3[op]
            return (offset << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
            
        elif op in ['sw', 'sh', 'sb']:
            rs2 = parse_reg(args[0])
            m = re.match(r'(-?\d+)\s*\(\s*(\w+)\s*\)', args[1])
            offset = int(m.group(1)) if m else 0
            rs1 = parse_reg(m.group(2)) if m else parse_reg(args[1])
            funct3 = FUNCT3[op]
            imm = offset & 0xFFF
            imm_11_5 = (imm >> 5) & 0x7F
            imm_4_0 = imm & 0x1F
            return (imm_11_5 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (imm_4_0 << 7) | opcode
            
        elif op in ['beq', 'bne', 'blt', 'bge', 'bltu', 'bgeu']:
            rs1 = parse_reg(args[0])
            rs2 = parse_reg(args[1])
            if args[2] in self.labels:
                offset = self.labels[args[2]] - addr
            else:
                offset = parse_imm(args[2])
            funct3 = FUNCT3[op]
            imm = offset & 0x1FFE
            imm_12 = (offset >> 12) & 1
            imm_10_5 = (offset >> 5) & 0x3F
            imm_4_1 = (offset >> 1) & 0xF
            imm_11 = (offset >> 11) & 1
            return (imm_12 << 31) | (imm_10_5 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (imm_4_1 << 8) | (imm_11 << 7) | opcode
            
        elif op == 'jal':
            rd = parse_reg(args[0])
            if args[1] in self.labels:
                offset = self.labels[args[1]] - addr
            else:
                offset = parse_imm(args[1])
            imm = offset & 0x1FFFFE
            imm_20 = (offset >> 20) & 1
            imm_10_1 = (offset >> 1) & 0x3FF
            imm_11 = (offset >> 11) & 1
            imm_19_12 = (offset >> 12) & 0xFF
            return (imm_20 << 31) | (imm_19_12 << 12) | (imm_11 << 20) | (imm_10_1 << 21) | (rd << 7) | opcode
            
        else:
            raise ValueError(f"Unknown instruction: {op}")

def assemble(input_file: str, output_file: str, format: str = 'hex'):
    """汇编主函数"""
    with open(input_file, 'r') as f:
        lines = f.readlines()
    
    asm = Assembler()
    asm.first_pass(lines)
    codes = asm.second_pass()
    
    with open(output_file, 'w') as f:
        if format == 'hex':
            for code in codes:
                f.write(f"{code:08x}\n")
        elif format == 'bin':
            for code in codes:
                f.write(f"{code:032b}\n")
        elif format == 'coe':
            f.write("memory_initialization_radix=16;\n")
            f.write("memory_initialization_vector=\n")
            for i, code in enumerate(codes):
                comma = ',' if i < len(codes) - 1 else ';'
                f.write(f"{code:08x}{comma}\n")
        elif format == 'mif':
            f.write("WIDTH=32;\n")
            f.write(f"DEPTH={len(codes)};\n")
            f.write("ADDRESS_RADIX=HEX;\n")
            f.write("DATA_RADIX=HEX;\n")
            f.write("CONTENT BEGIN\n")
            for i, code in enumerate(codes):
                f.write(f"  {i:04X} : {code:08X};\n")
            f.write("END;\n")

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("Usage: assembler.py <input.asm> <output.hex> [format]")
        print("Formats: hex, bin, coe, mif")
        sys.exit(1)
    
    fmt = sys.argv[3] if len(sys.argv) > 3 else 'hex'
    assemble(sys.argv[1], sys.argv[2], fmt)
