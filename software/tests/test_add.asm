# RISC-V加法测试程序
# 测试基本算术和逻辑指令

_start:
    # 测试 ADDI
    addi x1, x0, 5          # x1 = 5
    addi x2, x1, 10         # x2 = 15
    
    # 测试 ADD
    add x3, x1, x2          # x3 = 20 (5 + 15)
    
    # 测试 SUB
    sub x4, x2, x1          # x4 = 10 (15 - 5)
    
    # 测试 AND/OR/XOR
    and x5, x3, x4          # x5 = 20 & 10 = 4
    or  x6, x3, x4          # x6 = 20 | 10 = 30
    xor x7, x3, x4          # x7 = 20 ^ 10 = 26
    
    # 测试 LUI
    lui x8, 0x12345         # x8 = 0x12345000
    
    # 测试移位
    slli x9, x1, 2          # x9 = 5 << 2 = 20
    srli x10, x9, 1         # x10 = 20 >> 1 = 10
    
    # 测试SLT
    slt x11, x1, x2         # x11 = 1 (5 < 15)
    
    # 设置成功标志
    addi x28, x0, 1         # x28 = 1 (成功)

halt:
    jal x0, halt
