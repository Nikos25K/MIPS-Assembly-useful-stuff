# Reverse the number:
#move $t1, $zero   # Initialize the reversed number to zero    
#loop:
#li $s6, 10
#div $t0, $s6    # Divide the number by 10
#mflo $t0       # Move the quotient back to $t0
#mfhi $t2       # Move the remainder to $t2
#mul $t1, $t1, 10  # Multiply the reversed number by 10
#add $t1, $t1, $t2  # Add the remainder to the reversed number        
#bnez $t0, loop  # Branch if $t0 is not zero


#Prime
li $t4, 3
ble $t0, $t4, pr	#x<=3
li $t5, 2
loop:
beq $t0, $t5, pr
div $t0, $t5
mfhi $s0
beqz $s0, npr
addi $t5, $t5, 1
j loop
