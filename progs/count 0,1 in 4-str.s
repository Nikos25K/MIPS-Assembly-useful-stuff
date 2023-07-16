.text
.globl main
main:

li $v0, 4
la $a0, msg
syscall

li $v0, 8
li $a1, 5
la $a0, str
syscall

move $s0, $a0
li $v0, 4
move $a0, $s0
syscall

    # Convert the characters into a word
    lb $t0, ($s0)    # Load the first character into $t0
    lb $t1, 1($s0)   # Load the second character into $t1
    lb $t2, 2($s0)   # Load the third character into $t2
    lb $t3, 3($s0)   # Load the fourth character into $t3

    sll $t0, $t0, 24 # Shift the first character to the leftmost position
    sll $t1, $t1, 16 # Shift the second character to the left position
    sll $t2, $t2, 8  # Shift the third character to the middle position

    or $t0, $t0, $t1 # Combine the first and second characters
    or $t0, $t0, $t2 # Combine the result with the third character
    or $t0, $t0, $t3 # Combine the result with the fourth character

add $t2, $zero, $zero
loop:
andi $t1, $t0, 1
add $t2, $t2, $t1
srl $t0, $t0, 1
bne $t0, $zero, loop
add $t1, $zero, 32
sub $t1, $t1, $t2

li $v0, 4
la $a0, as
syscall

li $v0, 1
move $a0, $t2
syscall

li $v0, 4
la $a0, mhde
syscall

li $v0, 1
move $a0, $t1
syscall

li $v0, 10
syscall



.data
str: .space 5
msg: .asciiz "Give:"
as: .asciiz "assoi:"
mhde: .asciiz "mhden:"
word1: .word 0x11111111
