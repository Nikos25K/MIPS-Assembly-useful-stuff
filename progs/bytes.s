.data
ReadInt: .asciiz "Give integer:"
endl: .asciiz "\n"
MaxMsg: .asciiz "\n\nLargest byte value is: "
MinMsg: .asciiz "\nSmallest byte value is: "
SumMsg: .asciiz "\nSum of bytes is: "
AvgMsg: .asciiz "\nMean of bytes is: "

.text
.globl main

main:

   la $a0, ReadInt
   jal print_string

   jal read_int
   move $s0, $v0

   la $a0, endl
   jal print_string

   move $a0, $s0
   jal print_int

   beq $s0, $zero, exit
######################################
   move $a0, $s0
   li  $t0, -128         # t0 register for the max
   li  $t1, 128          # t1 register for the min
   add $t2, $zero, $zero # t2 register for the sum

   li $t3, 0xFF000000    # t3 mask for the leftmost byte
   li $t4, 4             # t4 byte counter

next_byte:
   and $t5, $a0, $t3
   sra $t5, $t5, 24

   slt $t6, $t0, $t5
   movn $t0, $t5, $t6

   slt $t6, $t5, $t1
   movn $t1, $t5, $t6

   add $t2, $t2, $t5

   sll $a0, $a0, 8
   addi $t4, $t4, -1
   bne $t4, $zero, next_byte
#######################################
   la $a0, MaxMsg
   jal print_string

   move $a0, $t0
   jal print_int

   la $a0, MinMsg
   jal print_string

   move $a0, $t1
   jal print_int

   la $a0, SumMsg
   jal print_string

   move $a0, $t2
   jal print_int

   la $a0, AvgMsg
   jal print_string

   li $t5, 4
   div $t2, $t5
   mflo $a0
   jal print_int

   la $a0, endl
   jal print_string

   j main
#########################################
exit:
    li $v0, 10
    syscall

print_string:
    li $v0, 4
    syscall
    jr $ra

read_int:
    li $v0, 5
    syscall
    jr $ra

print_int:
    li $v0, 1
    syscall
    jr $ra
