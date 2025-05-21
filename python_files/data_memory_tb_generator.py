import random
import os

OUT_FILE = "./test/data_memory_tb_full.txt"
DMEM_SIZE = 1024

test_vectors = []

for addr in range(DMEM_SIZE):
    offset = random.choice([0, 1, 2, 3])
    mem_size = random.choice([0b00, 0b01, 0b10])  # byte, half, word
    unsigned_load = random.choice([0, 1])         # sign/zero extend

    if mem_size == 0b00:  # byte
        wr_data = random.randint(0, 0xFF)
        full_addr = (addr << 2) + offset
        exp_data = wr_data if unsigned_load else ((wr_data if wr_data < 0x80 else wr_data - 0x100) & 0xFFFFFFFF)

    elif mem_size == 0b01:  # half
        wr_data = random.randint(0, 0xFFFF)
        offset = random.choice([0, 2])  # hizalı erişim
        full_addr = (addr << 2) + offset
        exp_data = wr_data if unsigned_load else ((wr_data if wr_data < 0x8000 else wr_data - 0x10000) & 0xFFFFFFFF)

    else:  # word
        wr_data = random.randint(0, 0xFFFFFFFF)
        offset = 0
        full_addr = addr << 2
        exp_data = wr_data

    test_vectors.append((full_addr, wr_data, mem_size, unsigned_load, exp_data))

# Dosyaya yaz
with open(OUT_FILE, "w") as f:
    for addr, wr_data, mem_size, unsigned_load, _ in test_vectors:
        f.write(f"{addr:08x} {wr_data:08x} {mem_size:02b} {unsigned_load}\n")
    for addr, _, mem_size, unsigned_load, exp in test_vectors:
        f.write(f"{addr:08x} {mem_size:02b} {unsigned_load} {exp:08x}\n")

print("✅ Test dosyası yazıldı.")
print(f"📁 Yol: {os.path.abspath(OUT_FILE)}")
