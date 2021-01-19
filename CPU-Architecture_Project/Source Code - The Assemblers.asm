.data
    space:   	.asciiz " "
    endl:    	.asciiz "\n"
    card:    	.asciiz "\nCARD "
    string1:    .asciiz "\nIs your number on this list? \nYes(1) or No(0): "
    string2:    .asciiz "\n\nYour number is: "
    string3:    .asciiz "\n\nDo you want to play again? "
    theirNum:   .word 0 # start the user number at zero
    
.text
main:    
	li $v0, 4 #print newline
    	la $a0, endl
    	syscall
    	li $v0, 4 #print newline
    	la $a0, endl
    	syscall
	li $s1, 1 #card number
    	li $s0, 1 #bit to mask
    	jal nums
    	jal Card1
    	li $s0, 2 #now mask second bit
    	jal nums
    	jal Card2
    	li $s0, 4 #mask third bit
    	jal nums
    	jal Card3
    	li $s0, 8 #mask fourth bit
    	jal nums
    	jal Card4
    	li $s0, 16 #mask fifth bit
    	jal nums
    	jal Card5
    	li $s0, 32 #mask sixth bit
    	jal nums
    	jal Card6
    	jal Calc
    	beq $t0, $zero, exit
    	j main
#loop uses bit masking to count through numbers up to 63.
nums:    
	li $s3, 64 #upper bound of loop
    	li $s2, 0 #counter
    	li $s7, -1 #counter that will let us print a newline every 6 nums
    	li $v0, 4 #print "CARD "
    	la $a0, card
    	syscall
    	li $v0, 1 #print card number
    	move $a0, $s1
    	syscall
    	addi $s1, $s1, 1 #increment card number
    	li $v0, 4 #print newline
    	la $a0, endl
    	syscall
#   
Loop:     
	bge $s2, $s3, end
    	or $s2, $s2, $s0 #MASK COUNTER with contents of s0
    
    	li $v0, 1 #print integer
    	move $a0, $s2
    	syscall
    
    	li $v0, 4 #print space
    	la $a0, space
    	syscall
    
    	addi $s2, $s2, 1
    	addi $s7, $s7, 1
    	beq $s7, 6, endline
    	j Loop
#  
endline: 
	li $v0, 4
    	la $a0, endl
    	syscall
    	li $s7, 0
    	j Loop
# 
Card1:  
	li $v0, 4    # string preperation
    	la $a0, string1    
    	syscall
    	li $v0, 5
    	syscall        # ineteger read
    	move $t0, $v0
    	sw $t0, 4($sp)        # pushign onto stack
    	jr $ra
#    
Card2:    
	li $v0, 4    # string preperation
    	la $a0, string1    
    	syscall
    	li $v0, 5
    	syscall        # ineteger read
    	move $t0, $v0
    	sw $t0, 8($sp)        # pushign onto stack
    	jr $ra
#    
Card3:    
	li $v0, 4    # string preperation
    	la $a0, string1    
    	syscall
    	li $v0, 5
    	syscall        # ineteger read
    	move $t0, $v0
    	sw $t0, 12($sp)        # pushign onto stack
    	jr $ra
#    
Card4:    
	li $v0, 4    # string preperation
    	la $a0, string1    
    	syscall
    	li $v0, 5
    	syscall        # ineteger read
    	move $t0, $v0
    	sw $t0, 16($sp)        # pushing onto stack
    	jr $ra
#   
Card5:    
	li $v0, 4    # string preperation
    	la $a0, string1    
    	syscall
    	li $v0, 5
    	syscall        # ineteger read
    	move $t0, $v0
    	sw $t0, 20($sp)        # pushign onto stack
    	jr $ra
#
Card6:    
	li $v0, 4    # string preperation
    	la $a0, string1    
    	syscall
    	li $v0, 5
    	syscall        # ineteger read
    	move $t0, $v0
    	sw $t0, 24($sp)        # pushign onto stack
    	jr $ra
#
end:    
	li $v0, 4 #print endline
    	la $a0, endl
    	syscall
    	jr $ra

Calc:    
	li $t0, 0
    	lw $t0, 24($sp)    # popping off stack
    	li $t1, 32        # getting last input digit (6th binary digit)
    	mult $t1, $t0    # mulitplying by 32 and storing it in t2 because 6th digit is (2^5) or 32
    	mflo $t6
    	add $t2, $t2, $t6
    
    	lw $t0, 20($sp)    # popping off stack
    	li $t1, 16        # getting 5th binary digit
    	mult $t1, $t0    # mulitplying by 16 and storing it in t2 because 5th digit is (2^4) or 16
    	mflo $t6
    	add $t2, $t2, $t6    
    
    	lw $t0, 16($sp)    # popping off stack
    	li $t1, 8        # gettign 4th binary digit
    	mult $t1, $t0    # mulitplying by 8 and storing it in t2 because 4th digit is (2^3) or 8
    	mflo $t6
    	add $t2, $t2, $t6
    
    	lw $t0, 12($sp)    # popping off stack
    	li $t1, 4        # getting 3rd binary digit
    	mult $t1, $t0    # mulitplying by 4 and storing it in t2 because 3rd digit is (2^2) or 
    	mflo $t6
    	add $t2, $t2, $t6
    
    	lw $t0, 8($sp)        # popping off stack
    	li $t1, 2        # getting 2nd binary digit
    	mult $t1, $t0    # mulitplying by 2 and storing it in t2 because 2nd digit is (2^1) or 2
    	mflo $t6
    	add $t2, $t2, $t6
    
    	lw $t0, 4($sp)        # popping off stack
    	li $t1, 1        # getting 1st binary digit
    	mult $t1, $t0    # mulitplying by 1 and storing it in t2 because 1st digit is (2^0) or 1
    	mflo $t6
    	add $t2, $t2, $t6
    	la $t6, theirNum    # loading theirNum to store the contents
    	move $t6, $t2        # stroing the result in theirNum
    
    	li $v0, 4    # string preperation
    	la $a0, string2    
    	syscall
    	li $v0, 1    # integer print
    	move $a0, $t2
    	syscall
    	li $v0, 4    # string preperation
    	la $a0, string3    
    	syscall
    	li $v0, 5
    	syscall        # ineteger read
    	move $t0, $v0
    	li $t2, 0
	jr $ra
    
exit:    
	li $v0, 10
    	syscall


