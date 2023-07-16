#checks if a number is in the string

li $a1, 11	#reads the 10char string
la $a0, str
li $v0, 8
syscall
move $t0, $a0
li $t2, 0

loop:
lb $t1, ($t0)
addi $t3, $t1, -108	#ascii for l
beqz $t3, exit
move $a0, $t1
li $v0, 11
syscall
addi $t0, $t0, 1
j loop


#prints number of chars given
move $s1, $a0	#string stored
move $t0, $v0	#integer stored
beqz $t0, exit
li $t4, 0
loop:
lb $s2, ($s1)
beqz $s2, exit
li $v0, 11
move $a0, $s2
syscall
addi $t0, $t0, -1
beqz $t0, exit
addi $s1, $s1, 1
j loop
