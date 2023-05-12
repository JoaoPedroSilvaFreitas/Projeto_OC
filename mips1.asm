.eqv size 20 ## define size

.data
	vet: 	
		.align 2
		.space 80  #20 x 4 bits
		
.text
			
zeraVetor:

jr $ra

valorAleatorio: # valorAleatorio(ultimoValor, 47, 97, 337, 3);

	mul $v0, $a0, $a1 # a * b
	add $v0, $v0, $a2 #(a * b) + c
	div $v0, $v0, $a3 #((a * b) + c)/d
	sub $v0, $v0, $s3 #(((a * b) + c)/d)-e
	jr $ra

imprimeVetor:

	jr $ra

troca:

	jr $ra
	
inicializaVetor: #(int vetor[], int tamanho, int ultimoValor)

	bne $a1, 0 , FIM  #Verifica se tamanho = 0
	li $ra, 0
	jr $ra
	FIM : #fim if
	
	move $a0, $a2 #armazena ultimoValor no registrador a0
	move $t0, $a1 #armazena tamanho no registrador t0
	
	li $a1, 47
	li $a2, 97
	li $a3, 337
	li $s3, 3
	jal valorAleatorio
	move $s1, $v0
	addi $t0, $t0, -1                #tamanho - 1
	sw $s1, vet($t0)            #vetor[tamanho - 1] = novoValor;
	jal inicializaVetor
			
main:
	li $a2, 71 #armazena 71 no registrador a2
	jal inicializaVetor 
	move $s0 , $v0
