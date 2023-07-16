.text
.globl main
main:

li $v0, 4
la $a0, msg
syscall

li $v0, 8
li $a1, 16
la $a0, str
syscall

move $s0, $a0
li $v0, 4
move $a0, $s0
syscall

li $v0, 4
la $a0, new
syscall

move $t0, $s0
li $s1, -1

loop2:
lb $t1, ($t0)
beqz $t1, st
li $v0, 11
move $a0, $t1
syscall
addi $s1, $s1, 1
addi $t0, $t0, 1
j loop2 #s1 num of chars

st:
li $s3, -2
loop1:
addi $s3, $s3, 1
beq $s3, $s1, exit
move $t0, $s0
li $s2, -1
loop3:
lb $s5, ($t0)
beqz $s5, loop1
beq $s3, $s2, star
bne $s3, $s2, ch
cont:
addi $s2, $s2, 1
addi $t0, $t0, 1
j loop3
j loop1


pri:
li $v0, 4
la $a0, new
syscall

li $v0, 1
move $a0, $s1
syscall

exit:
li $v0, 10
syscall

ch:
li $v0, 11
move $a0, $s5
syscall
j cont

star:
li $v0, 11
li $t6, 42
move $a0, $t6
syscall
j cont

.data
msg: .asciiz "Give string:"
str: .space 16
new: .asciiz "\n"
