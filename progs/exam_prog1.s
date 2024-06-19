.data
    prompt:      .asciiz "Enter an integer n (0 to end): "
    end_msg:     .asciiz "End of program\n"
    sum_msg:     .asciiz "Sum(1/n) = "

.text
    .globl main

mainn:
    # Print prompt message
    li $v0, 4                # Load syscall code for print_string
    la $a0, prompt           # Load address of prompt message
    syscall

    # Read integer n
    li $v0, 5                # Load syscall code for read_int
    syscall
    move $t0, $v0            # Save the integer n to $t0

    # Check if n is 0
    beq $t0, $zero, end_program

    # Call the sum_function
    move $a0, $t0            # Move n to $a0 for the function argument
    jal sum_function

    # Print sum message
    li $v0, 4                # Load syscall code for print_string
    la $a0, sum_msg          # Load address of sum message
    syscall

    # Print the result in $f0
    mov.d $f12, $f0          # Move the result to $f12 for print
    li $v0, 3                # Load syscall code for print_double
    syscall

    # Print a newline
    li $v0, 11               # Load syscall code for print_char
    li $a0, 10               # ASCII code for newline
    syscall

    # Repeat
    j mainn

end_program:
    # Print end message
    li $v0, 4                # Load syscall code for print_string
    la $a0, end_msg          # Load address of end message
    syscall

    # Exit program
    li $v0, 10               # Load syscall code for exit
    syscall

sum_function:
    # Save the return address
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $a0, 0($sp)

    # Initialize sum (double precision, so use $f2)
    li.d $f2, 0.0

    # Load integer n from $a0
    mtc1 $a0, $f4            # Move n to $f4
    cvt.d.w $f4, $f4         # Convert n to double precision

    # Compute 1/n (double precision)
    li.d $f6, 1.0
    div.d $f8, $f6, $f4      # f8 = 1/n

    # Add 1/n to sum
    add.d $f2, $f2, $f8

    # Return sum in $f0
    mov.d $f0, $f2

    # Restore the return address
    lw $a0, 0($sp)
    lw $ra, 4($sp)
    addi $sp, $sp, 8

    jr $ra                   # Return from function
