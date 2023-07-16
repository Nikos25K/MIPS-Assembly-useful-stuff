.text
 .globl main
main:
    li $v0, 6
    syscall
    li $v0, 4
    la $a0, msg1
    syscall
    li $v0, 2
    mov.s $f12, $f0
    syscall
 
    mfc1 $t8, $f12
    move $t0, $t8
    jal pr_endl
 
    sll $t0, $t0, 1
    srl $t0, $t0, 24
 
    la $a0, msg2
    jal pr_str
 
    move $a0, $t0
    li $t2, 128
    li $t3, 8
    jal print_exp
    jal pr_endl
 
    move $t0, $t8
    sll $t0, $t0, 9
    srl $t0, $t0, 9
    la $a0, msg3
    jal pr_str
    move $a0, $t0
    li $t2, 1
    sll $t2, $t2, 22
    li $t3, 23
    jal print_fraction
 
 
    j exit
 
pr_str:
    li $v0, 4
    syscall
    jr $ra
 
pr_endl:
    la $a0, endl
    li $v0, 4
    syscall
    jr $ra
 
pr_int:
    li $v0, 1
    syscall
    jr $ra
 
print_exp:
    and $a0, $t0, $t2
    srl $t2, $t2, 1
    sub $t3, $t3, 1
    srl $a0, $a0, $t3
    li $v0, 1
    syscall
    bne $t2, $zero, print_exp
    jr $ra
 
print_fraction:
    and $a0, $t0, $t2
    srl $t2, $t2, 1
    sub $t3, $t3, 1
    srl $a0, $a0, $t3
    li $v0, 1
    syscall
    bne $t2, $zero, print_fraction
    jr $ra
 
# Exits the program
exit:
    li $v0, 10
    syscall
 
.data
msg1: .asciiz "VALUE IS "
msg2: .asciiz "EXPONENT="
msg3: .asciiz "FRACTION="
endl: .asciiz "\n"
