# text segment # September 2017
# A progrsm in assembly MIPS that reads in a loop numbers bigger than # 0 and prints them as a sum of powers of 10 
# For example for 137 will print POWERS-SUM=1*10^2 + 3*10^1 + 7*10^0.
# The loop ends when 0 is given. Do not check for negative numbers.
	.text
		.globl __start
__start:

loop:	
	la $a0, giveInt
	jal printStr
	li $v0, 5
	syscall
	move $t9, $v0
	move $a0, $v0
	jal printInt	
	jal printEndl
	beqz $t9, end
	move $s1, $t9
	li $t0, 10
	li $t2, 0
	
loop2:
	div $s1, $t0
	mfhi $t1
	mflo $s1
	sb $t1, spaces($t2)
	addi $t2, $t2, 1
	bnez $s1, loop2	
	
print:
	addi $t2, $t2, -1
	lb $a0, spaces($t2)
	jal printInt	
	la $a0, star
	jal printStr	
	la $a0, dinami
	jal printStr		
	move $a0, $t2
	jal printInt		
	bnez $t2, addsymbol		
	jal printEndl	
	j loop
	
addsymbol:
	la $a0, addsym
	jal printStr
	j print
	
end:
	li $v0, 10
	syscall
	
printInt:
	li $v0, 1
	syscall
	jr $ra	
	
printStr:
	li $v0, 4		
	syscall
	jr $ra
	
printEndl:  
	la $a0, endl
	li $v0, 4		
	syscall
	jr $ra
			
	.data
spaces:	 .asciiz "                                " #32+\0
star:	 .asciiz "*"
dinami:	 .asciiz "10^"
addsym:	 .asciiz "+"
giveInt: .asciiz "Give integer:"
endl:	 .asciiz "\n"
