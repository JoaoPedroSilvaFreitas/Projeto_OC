.data
	vet: .space 80
	

#zeraVetor:
#jr $ra

#valorAleatorio:
#jr $ra



#troca:
#jr $ra
	
	
.text	
	j .main
	valorAleatorio:
		mult $a0, $a1
		mflo $t0
		add $t1,$t0,$a2
		div $t1, $a3
		mfhi $t2
		lw $t3,0($sp)
		sub $v0, $t2, $t3

		jr $ra
	
	
	inicializaVetor:
		slt $t0, $zero, $a1
		beq $t0,$zero,FIM
#		la $v0, vet 
		move $t7,$a1
		move $t1, $a0
		move $a0,$a2
		
		li $a1, 47
		li $a2, 97
		li $a3, 337
		li $t0, 3
		
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		addi $sp, $sp, -4
		sw  $t1, 0($sp)
		addi $sp, $sp, -4
		sw $t7, 0($sp)
		addi $sp, $sp, -4
		sw $t0 0($sp)
		
		jal valorAleatorio
		
		
		
		
		addi $sp, $sp, 4
		lw $t3, 0($sp)
		addi $sp, $sp, 4
		lw $t0, 0($sp)
		
		la $t5, ($t0)
		
		
		move $t1, $v0
		addi $t3,$t3 , -1
		li $t4, 4
		mult $t3, $t4
		mflo $t3
		#move $v0, $t4
		jal imprimeVetor
		sw $t1, 0($t0)
		jr $ra	
		FIM:
		addi $v0, $zero, 0
		jr $ra	
		
	imprimeVetor:
		li $v0,1
		syscall
		jr $ra
		
	.main:
		la $a0, vet
		addi $a1,$zero,20
		sw $a2, 80($a0)
		jal inicializaVetor
		
		add $s0, $zero,$v0
		addi $t0,$zero, 20
		sw $t0,80($s0)
	
		lw $a0, 80($s0)
		#jal imprimeVetor
		


			
	
