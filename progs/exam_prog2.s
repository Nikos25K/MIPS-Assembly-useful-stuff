.data
prompt: .asciiz "Enter a double precision floating point number: "
end_message: .asciiz "End of program\n"
separator: .asciiz "******************************\n"

.text
main:
    # Print prompt
    li $v0, 4          # syscall code for print_str
    la $a0, prompt     # load address of prompt
    syscall            # print the prompt

    # Read double precision floating point number
    li $v0, 7          # syscall code for read_double
    syscall            # read double from input
    mov.d $f12, $f0    # move the double from $f0 to $f12 for passing as argument

    # Check if the double is zero
    li.s $f2, 0.0      # load 0.0 into $f2
    c.eq.d $f12, $f2   # compare $f12 with 0.0
    bc1t end_program   # if equal, branch to end_program

    # Print newline
    li $v0, 11         # syscall code for print_char
    li $a0, '\n'       # newline character
    syscall            # print newline character

    # Call the procedure
    jal print_info     # jump and link to print_info

    # Print separator
    li $v0, 4          # syscall code for print_str
    la $a0, separator  # load address of separator
    syscall            # print the separator

    # Print newline after separator
    li $v0, 11         # syscall code for print_char
    li $a0, '\n'       # newline character
    syscall            # print newline character

    # Continue to step i (back to main)
    j main             # jump to main to repeat the process

end_program:
    # Print end message
    li $v0, 4          # syscall code for print_str
    la $a0, end_message # load address of end_message
    syscall            # print the end message

    # Exit
    li $v0, 10         # syscall code for exit
    syscall            # exit program

print_info:
    # Procedure to print sign, exponent, and fraction
    # $f12 contains the double passed as argument

    # Print sign as integer (0 or 1)
    mfc1 $t0, $f12     # move $f12 to integer register $t0
    andi $t0, $t0, 0x8000000000000000  # mask to get sign bit
    srl $t0, $t0, 5   # shift sign bit to LSB
    li $v0, 1          # syscall code for print_int
    move $a0, $t0      # move sign (0 or 1) to $a0
    syscall            # print sign as integer

    # Print newline
    li $v0, 11         # syscall code for print_char
    li $a0, '\n'       # newline character
    syscall            # print newline character

    # Print biased exponent as ASCII character
    mfc1 $t0, $f12     # move $f12 to integer register $t0
    andi $t0, $t0, 0x7FF0000000000000  # mask to get exponent bits
    srl $t0, $t0, 5   # shift right to get biased exponent
    addi $t0, $t0, -1023 # adjust to get unbiased exponent
    addi $t0, $t0, 48  # convert to ASCII character

    # Print exponent
    li $v0, 11         # syscall code for print_char
    move $a0, $t0      # move exponent ASCII to $a0
    syscall            # print exponent

    # Print newline
    li $v0, 11         # syscall code for print_char
    li $a0, '\n'       # newline character
    syscall            # print newline character

    # Print fraction as integer
    mfc1 $t0, $f12     # move $f12 to integer register $t0
    srl $t0, $t0, 5   # shift right to get integer fraction
    li $v0, 1          # syscall code for print_int
    move $a0, $t0      # move fraction to $a0
    syscall            # print fraction as integer

    # Print newline
    li $v0, 11         # syscall code for print_char
    li $a0, '\n'       # newline character
    syscall            # print newline character

    jr $ra             # jump back to return address (main)
