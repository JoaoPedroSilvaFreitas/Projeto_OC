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
	inicializaVetor:
		
		la $v0, vet 
		jr $ra	
		
	imprimeVetor:
		li $v0,1
		syscall
		jr $ra
		
	.main:
		jal inicializaVetor
		add $s0, $zero,$v0
		addi $t0,$zero, 20
		sw $t0,80($s0)
	
		lw $a0, 80($s0)
		jal imprimeVetor
		


			
	
