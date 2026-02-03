_start:
    addi x1, x0, 10
    addi x2, x0, 20
    
    # 测试BEQ (不跳转)
    beq x1, x2, fail
    
    # 测试BNE (跳转)
    bne x1, x2, branch1
    
    addi x28, x0, 2
    jal x0, halt

branch1:
    # 测试BLT
    blt x2, x1, fail
    blt x1, x2, branch2
    
    addi x28, x0, 2
    jal x0, halt

branch2:
    # 测试JAL（向前跳转）
    jal x3, branch3
    
    addi x28, x0, 2
    jal x0, halt

branch3:
    # 所有测试通过
    addi x28, x0, 1         # 成功

halt:
    jal x0, halt

fail:
    addi x28, x0, 2
    jal x0, halt
