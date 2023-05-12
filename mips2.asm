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
		sub $v0, $t2, $at

		jr $ra
	
	
	inicializaVetor:
		slt $t0, $zero, $a1
		beq $t0,$zero,FIM
		la $v0, vet 
		
		li $a0 , $a3
		li $a1, 47
		li $a2, 97
		li $a3, 337
		li $at, 3
		
		jal valorAleatorio
		
		move $t0, $v0
		addi $t1, $a3, -1
		addi $t2($a2), $t0, 0
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
		addi $a2, 80($a0),0
		jal inicializaVetor
		
		add $s0, $zero,$v0
		addi $t0,$zero, 20
		sw $t0,80($s0)
	
		lw $a0, 80($s0)
		jal imprimeVetor
		


			
	
