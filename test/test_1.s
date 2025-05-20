# Arithmetic
ADDI x1, x0, 10       # x1 = 10
ADDI x2, x0, 5        # x2 = 5
ADD  x3, x1, x2       # x3 = 10 + 5 = 15
SUB  x4, x1, x2       # x4 = 10 - 5 = 5

# Logic
AND  x5, x1, x2       # x5 = x1 & x2
ANDI x6, x1, 3        # x6 = x1 & 3
OR   x7, x1, x2       # x7 = x1 | x2
ORI  x8, x1, 2        # x8 = x1 | 2
XOR  x9, x1, x2       # x9 = x1 ^ x2
XORI x10, x1, 7       # x10 = x1 ^ 7

# Set
SLT   x11, x2, x1     # x11 = (5 < 10) = 1
SLTI  x12, x2, 6      # x12 = (5 < 6) = 1
SLTU  x13, x2, x1     # x13 = (5 < 10 unsigned) = 1
SLTIU x14, x2, 6      # x14 = (5 < 6 unsigned) = 1

# Shift
SLL  x15, x2, x1      # x15 = x2 << x1 (5 << 10)
SLLI x16, x2, 1       # x16 = x2 << 1
SRL  x17, x1, x2      # x17 = x1 >> x2 (logical)
SRLI x18, x1, 1       # x18 = x1 >> 1 (logical)
SRA  x19, x1, x2      # x19 = x1 >> x2 (arith)
SRAI x20, x1, 1       # x20 = x1 >> 1 (arith)

# Memory
LUI x21, 0x10000      # x21 = 0x10000000 (base addr)
SW   x1, 0(x21)       # Mem[0x10000000] = x1
LW   x22, 0(x21)      # x22 = Mem[0x10000000]
SB   x2, 4(x21)       # Mem[0x10000004] = x2[7:0]
LB   x23, 4(x21)      # x23 = Mem[0x10000004][7:0]

# PC-related
LUI   x24, 0x12345    # x24 = 0x12345000
AUIPC x25, 0x1        # x25 = PC + 0x1000

# Jumps
JAL x26, label_jump
ADDI x27, x0, 0       # Bu atlanır
label_jump:
JALR x28, 0(x26)      # x28 = PC+4; PC = x26

# Branches
ADDI x29, x0, 10
ADDI x30, x0, 10
ADDI x31, x0, 5

BEQ   x29, x30, label_beq   # eşit → zıpla
ADDI  x1, x0, 99            # atlanır
label_beq:

BNE   x29, x31, label_bne   # farklı → zıpla
ADDI  x2, x0, 99
label_bne:

BLT   x31, x29, label_blt   # 5 < 10 → zıpla
ADDI  x3, x0, 99
label_blt:

BGE   x29, x31, label_bge   # 10 ≥ 5 → zıpla
ADDI  x4, x0, 99
label_bge:

BLTU  x31, x29, label_bltu  # unsigned karşılaştırma
ADDI  x5, x0, 99
label_bltu:

BGEU  x29, x31, label_bgeu  # unsigned karşılaştırma
ADDI  x6, x0, 99
label_bgeu:
