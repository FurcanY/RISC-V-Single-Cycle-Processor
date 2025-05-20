import random
import os
import numpy as np


OUT_FILE = "./test/register_file.txt"
register_32 = []
rs1_addr = 0
rs2_addr = 0
'''
    ilk olarak:
        -rastgele olarak register değerleri olusturur (32 bit).
        -testbench'de bu veriler tek tek yazılır (write_enable = 1)
    daha sonra:
    -rastgele rs1 rs2 address'leri olusturur ve buradan okunacak olan degerleri gosterir. dosyaya yazar.
    -testebenchde bu address degerleri ile register'daki degerler okunur, kontrol edilir (write_eable = 0)

    ilk 32 satir: rastgele register degerleri
    son 32 satir: register addres'leri ve o addreslerdeki degerler.

    dosyadan okuma sirasi:
    src_register1 src_register2 src_register1_value src_register2_value

'''

with open(OUT_FILE, "w") as f:
        for _ in range(32):
            reg_value = random.randint(0, 0xFFFFFFFF)
            f.write(f"{reg_value:08x}\n")
            register_32.append(reg_value) # daha sonra kullanmak için register değerini yazilir.
        for _ in range(32):
            rs1_addr = random.randint(0,31) #rastegele addres degeri olusturulur.
            rs2_addr = random.randint(0,31) #rastegele addres degeri olusturulur.
            f.write(f"{rs1_addr:05x} {rs2_addr:05x} {register_32[rs1_addr]:08x} {register_32[rs2_addr]:08x}\n")
            
        

print("dosya basarili bir sekilde olusturuldu.")
print(f"📄 Dosya: {os.path.abspath(OUT_FILE)}")