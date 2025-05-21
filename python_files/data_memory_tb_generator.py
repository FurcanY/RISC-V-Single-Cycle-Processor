import random
import os

'''              
    logic [XLEN-1:0]   data_addr         =  10 bitlik address (DMEM_SIZE = 1024)       
    logic [XLEN-1:0]   data_write_data   =  memory'ye yazılacak olan veri   
    logic              data_write_enable =  1 olursa yazma işlemi oluyor
    logic [XLEN-1:0]   data_read_data    =  memory'den okunan veri


    yapılan işlemler:
        - memory'nin tümüne rastgele veri yaz
        - daha sonra bu verileri okuma testi yap (testbench içerisinde)
'''

OUT_FILE = "./test/data_memory_tb.txt"

mem_address = 0
mem_value   = 0
mem_values = []

with open(OUT_FILE,"w") as f:
    for _ in range (1024):
        mem_address = _
        mem_value   = random.randint(0,0xFFFFFFFF) #rastgele 32 bitlik veri
        mem_values.append(mem_value)

        f.write (f"{mem_address:03x} {mem_value:08x}\n")
    for i in range (1024):
        f.write (f"{mem_values[i]:08x}\n")

print (f"testbench ram verileri olusturuldu")
print (f"Dosya= {os.path.abspath(OUT_FILE)}")