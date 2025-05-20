
from enum import Enum
import os
import random




'''
    elimizde bir adet gelen source immediate olacak.
    immediate source'dan gelen sinyale göre bunu extend edecek.

    IMM_I = 3'b000,
    IMM_S = 3'b001,
    IMM_B = 3'b010,
    IMM_U = 3'b011,
    IMM_J = 3'b100 

    örnek:
        IMM_I olursa,
        instruction'un 31.bitini extend instructionun 31 11 bit arasına ekliyor
        instruction 30dan 20e kadar olan bitlerini extend inst.nun 10 ile 0 bitleri yapıyor.


'''

from enum import Enum
import os
import random

# Çıkış dosyası
OUT_FILE = "./test/immediate_extend.txt"

# Immediate türleri enum
class ImmType(Enum):
    IMM_I = 0
    IMM_S = 1
    IMM_B = 2
    IMM_U = 3
    IMM_J = 4

# Sign extension
def sign_extend(value, bits):
    sign_bit = 1 << (bits - 1)
    return (value & (sign_bit - 1)) - (value & sign_bit)

# Immediate çıkartma
def extract_immediate(inst: int, imm_type: ImmType) -> int:
    if imm_type == ImmType.IMM_I:
        imm = (inst >> 20) & 0xFFF
        return sign_extend(imm, 12)
    elif imm_type == ImmType.IMM_S:
        imm_11_5 = (inst >> 25) & 0x7F
        imm_4_0  = (inst >> 7) & 0x1F
        imm = (imm_11_5 << 5) | imm_4_0
        return sign_extend(imm, 12)
    elif imm_type == ImmType.IMM_B:
        imm_12   = (inst >> 31) & 0x1
        imm_10_5 = (inst >> 25) & 0x3F
        imm_4_1  = (inst >> 8) & 0xF
        imm_11   = (inst >> 7) & 0x1
        imm = (imm_12 << 12) | (imm_11 << 11) | (imm_10_5 << 5) | (imm_4_1 << 1)
        return sign_extend(imm, 13)
    elif imm_type == ImmType.IMM_U:
        return inst & 0xFFFFF000
    elif imm_type == ImmType.IMM_J:
        imm_20    = (inst >> 31) & 0x1
        imm_10_1  = (inst >> 21) & 0x3FF
        imm_11    = (inst >> 20) & 0x1
        imm_19_12 = (inst >> 12) & 0xFF
        imm = (imm_20 << 20) | (imm_19_12 << 12) | (imm_11 << 11) | (imm_10_1 << 1)
        return sign_extend(imm, 21)
    return 0

# Instruction üretimi
def generate_random_instruction(imm_type: ImmType):
    rd  = random.randint(1, 31)
    rs1 = random.randint(1, 31)
    rs2 = random.randint(1, 31)

    if imm_type == ImmType.IMM_I:
        imm = random.randint(-2048, 2047)
        imm12 = imm & 0xFFF
        inst = (imm12 << 20) | (rs1 << 15) | (0b000 << 12) | (rd << 7) | 0b0010011  # ADDI
        asm = f"addi x{rd}, x{rs1}, {imm}"
    elif imm_type == ImmType.IMM_S:
        imm = random.randint(-2048, 2047)
        imm12 = imm & 0xFFF
        imm_11_5 = (imm12 >> 5) & 0x7F
        imm_4_0 = imm12 & 0x1F
        inst = (imm_11_5 << 25) | (rs2 << 20) | (rs1 << 15) | (0b010 << 12) | (imm_4_0 << 7) | 0b0100011  # SW
        asm = f"sw x{rs2}, {imm}(x{rs1})"
    elif imm_type == ImmType.IMM_B:
        imm = random.randint(-4096, 4095)
        imm13 = imm & 0x1FFF
        imm_12 = (imm13 >> 12) & 0x1
        imm_10_5 = (imm13 >> 5) & 0x3F
        imm_4_1 = (imm13 >> 1) & 0xF
        imm_11 = (imm13 >> 11) & 0x1
        inst = (imm_12 << 31) | (imm_10_5 << 25) | (rs2 << 20) | (rs1 << 15) | (0b000 << 12) | (imm_4_1 << 8) | (imm_11 << 7) | 0b1100011  # BEQ
        asm = f"beq x{rs1}, x{rs2}, {imm}"
    elif imm_type == ImmType.IMM_U:
        imm = random.randint(0, 0xFFFFF)
        inst = (imm << 12) | (rd << 7) | 0b0110111  # LUI
        asm = f"lui x{rd}, 0x{imm:x}"
    elif imm_type == ImmType.IMM_J:
        imm = random.randint(-2**20, 2**20 - 1)
        imm21 = imm & 0x1FFFFF
        imm_20 = (imm21 >> 20) & 0x1
        imm_19_12 = (imm21 >> 12) & 0xFF
        imm_11 = (imm21 >> 11) & 0x1
        imm_10_1 = (imm21 >> 1) & 0x3FF
        inst = (imm_20 << 31) | (imm_19_12 << 12) | (imm_11 << 20) | (imm_10_1 << 21) | (rd << 7) | 0b1101111  # JAL
        asm = f"jal x{rd}, {imm}"
    else:
        inst = 0
        asm = "nop"

    inst &= 0xFFFFFFFF  # ✅ garantili 32-bit sınırla
    return inst, asm

# Dosyaya yazma
def generate_and_log(n=50, output_file=OUT_FILE, isASM=False):
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    with open(output_file, "w") as f:
        for _ in range(n):
            typ = random.choice(list(ImmType))
            inst, asm = generate_random_instruction(typ)
            extended = extract_immediate(inst, typ)
            if (isASM):
                f.write(f"{asm:<30} {inst:08x} {extended & 0xFFFFFFFF:08x} {typ.value}\n")
            else:
                f.write(f"{inst:08x} {extended & 0xFFFFFFFF:08x} {typ.value}\n")


if __name__ == "__main__":
    generate_and_log(n = 200)
    print("✅ Assembly açıklamalı test dosyası oluşturuldu.")
    print(f"📄 {os.path.abspath(OUT_FILE)}")
