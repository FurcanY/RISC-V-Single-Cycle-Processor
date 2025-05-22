addi x1, x0, 5      #// x1 = 5
addi x2, x0, 10     #// x2 = 10
blt  x1, x2, L1    #// if (x1 < x2) goto L1
addi x3, x0, 20     #// Bu satır atlanmalı
j    END           #// Koşul sağlanmadığında buraya gelinir

L1:
addi x3, x0, 30     #// Koşul sağlandığında x3 = 30 olur

END:
sw   x3, 0(x0)      #// Bellek[0] = x3