import random
import os
XLEN = 32
NUM_TESTS = 300
OUT_FILE = "./test/alu_test.txt"

# ALU operasyon enum sıralaması (Verilog enum sırası ile aynı olmalı)
ALU_OPS = { 
    0: "ADD",
    1: "SUB",
    2: "AND",
    3: "OR",
    4: "XOR",
    5: "SLL",
    6: "SRL",
    7: "SRA",
    8: "SLT",
    9: "SLTU",
    10: "LUI",
    11: "AUIPC"
}

def to_unsigned(val):
    return val & 0xFFFFFFFF

def to_signed(val):
    if val & (1 << 31):
        return val - (1 << 32)
    return val

def get_sign(val):
    return (val >> 31) & 1

def compute_alu(source_a, source_b, alu_op):
    carry = 0
    overflow = 0
    result = 0

    signed_a = to_signed(source_a)
    signed_b = to_signed(source_b)

    if alu_op == 0:  # ADD
        result = source_a + source_b
        carry = int(result > 0xFFFFFFFF)
        result = result & 0xFFFFFFFF
        overflow = int((get_sign(source_a) == get_sign(source_b)) and
                    (get_sign(result) != get_sign(source_a)))

    elif alu_op == 1:  # SUB
        result = source_a - source_b
        carry = int(source_a < source_b)
        result = result & 0xFFFFFFFF
        overflow = int((get_sign(source_a) != get_sign(source_b)) and
                   (get_sign(result) != get_sign(source_a)))

    elif alu_op == 2:  # AND
        result = source_a & source_b

    elif alu_op == 3:  # OR
        result = source_a | source_b

    elif alu_op == 4:  # XOR
        result = source_a ^ source_b

    elif alu_op == 5:  # SLL
        shamt = source_b & 0x1F  # Only use lower 5 bits
        result = (source_a << shamt) & 0xFFFFFFFF

    elif alu_op == 6:  # SRL
        shamt = source_b & 0x1F  # Only use lower 5 bits
        result = (source_a >> shamt) & 0xFFFFFFFF

    elif alu_op == 7:  # SRA
        shamt = source_b & 0x1F  # Only use lower 5 bits
        result = to_signed(source_a) >> shamt
        result = to_unsigned(result)

    elif alu_op == 8:  # SLT
        result = int(to_signed(source_a) < to_signed(source_b))

    elif alu_op == 9:  # SLTU
        result = int(source_a < source_b)

    elif alu_op == 10:  # LUI
        result = source_b  # source_b contains the immediate value

    elif alu_op == 11:  # AUIPC
        result = source_a + source_b  # source_a is PC, source_b is immediate
        result = result & 0xFFFFFFFF

    else:
        result = 0

    result = to_unsigned(result)
    zero = int(result == 0)
    negative = int((result >> 31) & 1)
    return result, zero, negative, carry, overflow

# Test vektörleri oluştur
with open(OUT_FILE, "w") as f:
    # Normal operasyonlar için rastgele testler
    for _ in range(NUM_TESTS - 100):  # Normal operasyonlar için daha az test
        source_a = random.randint(0, 0xFFFFFFFF)
        source_b = random.randint(0, 0xFFFFFFFF)
        alu_op = random.randint(0, 9)  # Normal operasyonlar

        result, zero, negative, carry, overflow = compute_alu(source_a, source_b, alu_op)
        f.write(f"{source_a:08x} {source_b:08x} {alu_op:02d} {result:08x} {zero} {negative} {carry} {overflow}\n")

    # LUI için özel testler
    for _ in range(50):
        source_a = random.randint(0, 0xFFFFFFFF)  # Don't care for LUI
        source_b = random.randint(0, 0xFFFFFFFF)  # Immediate value
        alu_op = 10  # LUI

        result, zero, negative, carry, overflow = compute_alu(source_a, source_b, alu_op)
        f.write(f"{source_a:08x} {source_b:08x} {alu_op:02d} {result:08x} {zero} {negative} {carry} {overflow}\n")

    # AUIPC için özel testler
    for _ in range(50):
        source_a = random.randint(0, 0xFFFFFFFF)  # PC value
        source_b = random.randint(0, 0xFFFFFFFF)  # Immediate value
        alu_op = 11  # AUIPC

        result, zero, negative, carry, overflow = compute_alu(source_a, source_b, alu_op)
        f.write(f"{source_a:08x} {source_b:08x} {alu_op:02d} {result:08x} {zero} {negative} {carry} {overflow}\n")

print(f"\n✅ {NUM_TESTS} adet test vektörü başarıyla oluşturuldu.")
print(f"📄 Dosya: {os.path.abspath(OUT_FILE)}")
