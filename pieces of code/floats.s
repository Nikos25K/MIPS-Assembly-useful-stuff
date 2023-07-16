############

.text
.globl _start
_start:

li $v0, 4
la $a0, newl
syscall

jal divis


exit:
li $v0, 10
syscall

#########

.data
first: .asciiz "Give first number:"
next: .asciiz "Give next number:"
newl: .asciiz "\n"

######################
.text

readint:		#stores in $t0
li $v0, 5
syscall
move $t0, $v0 
move $a0, $v0
li $v0, 1		#prints also
syscall


newline:		#newline
li $v0, 4
la $a0, newl
syscall
jr $ra


loop:
li $v0, 4
la $a0, next		#give next
syscall
jal readint		#reads int
#jal conv
jal newline	
bnez $t0, loop
jr $ra			#returns


conv: 			#converts to floating
mtc1 $t0, $f1
cvt.s.w $f0, $f1
mov.s $f12, $f0
li $v0, 2
syscall
jr $ra


divis:
jal readint
move $t1, $t0
jal readint
beqz $t0, exit
div $t1, $t0
mflo $s0		#quotient
mfhi $s1		#remainder
move $a0, $s0
li $v0, 1
syscall
jr $ra

######
#c.lt.s $f2, $f3		#compare if f2 < f3 branch to trr
#bc1t trr
#to idio isxyei me eq,ne,lt,le,gt,ge

####
#substract and hold decimals
#li.s $f8, 0.0		
#c.eq.s $f1, $f8	#an 0 telos
#bc1t exit
#cvt.w.s $f2, $f1	#kanei int
#mfc1 $t1, $f2		#apoth int se t1
#cvt.s.w $f3, $f2	#kanei float
#sub.s $f6, $f1, $f3	#afairei kai krata dekad
