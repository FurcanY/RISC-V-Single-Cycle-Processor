addi x1, x0, 5      #// x1 = 5
addi x2, x0, 10     #// x2 = 10
blt  x1, x2, L1    #// if (x1 < x2) goto L1
addi x3, x0, 20     #// Bu satır atlanmalı
j    END           #// Koşul sağlanmadığında buraya gelinir

L1:
addi x3, x0, 30     #// Koşul sağlandığında x3 = 30 olur

addi x1,x0, 20    # x1 = 20
addi x2,x0, 1    #x2 = 1
beq x1,x2 L2    # (x1==x2) olursa L2 gidilir, olmazsa END'e gidilir
j END

L2:
addi x6, x0,31  #x6 = 31 yapılır

END:
sw   x3, 0(x0)      #// Bellek[0] = x3

