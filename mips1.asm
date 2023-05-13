.eqv size 20                        #define size

.data
	vet: 	
		.align 2
		.space 80           #20 x 4 bits
		
.text

main:
	la $s0, vet                 #armazena endereço do vet
	li $a1, size                #armazena size no registrador a1
	li $a2, 71                  #armazena 71 no registrador a2
	move $a0, $s0               #armazena vet em $a0 para chamar função
	jal inicializaVetor 	    #(vet, SIZE, 71);
	syscall
	move $s5 , $v0              #soma = inicializaVetor
			
zeraVetor:                          #zeraVetor(int *inicio, int *fim)

	jr $ra

valorAleatorio:                     #valorAleatorio(int a, int b, int c, int d, int e)

	lw $t4, ($sp)               #recupera valor da pilha
	addi $sp, $sp, 4            #ajusta pilha
	mul $v0, $a0, $a1           # a * b
	add $v0, $v0, $a2           #(a * b) + c
	div $v0 , $a3               #((a * b) + c) % d
	mfhi $v0
	sub $v0, $v0, $t4           #(((a * b) + c) % d) - e
	jr $ra

imprimeVetor:                       #imprimeVetor(int vet[], int tam)

	jr $ra

troca:                              #troca(int *a, int *b)

	jr $ra
	
inicializaVetor:                    #inicializaVetor(int vetor[], int tamanho, int ultimoValor)

	bne $a1, 0 , FIM            #Verifica se tamanho = 0
	li $ra, 0
	jr $ra
	FIM :                       #fim if
	
	move $a0, $a2               #armazena ultimoValor no registrador a0
	move $t0, $a1               #armazena tamanho no registrador t0
	
	li $a1, 47
	li $a2, 97
	li $a3, 337
	li $t4, 3
	addi $sp, $sp, -4           #aloca pilha
	sw $t4, ($sp)               #armazena registrador t4 na pilha
	
	jal valorAleatorio          #(ultimoValor, 47, 97, 337, 3);
	
	move $s1, $v0               #novoValor = valorAleatorio
	addi $t0, $t0, -4           #tamanho - 1
	add $s1, $s1, $t0           #apontando para vetor[tamanho - 1]
	sw $s0, ($s1)		    #vetor[tamanho - 1] = novoValor;
	
	move $a1, $t0               #armazena tamanho do registrdor $a1 para chamar função
	move $a2, $a0               #armazena ultimoValor no registrador $a2 para chamar função
	
	addi $sp, $sp, -4           #aloca pilha
	add $v0, $v0, $s1           #novoValor + inicializaVetor
	sw $v0, ($sp)               #armazena retorno na pilha
	
	jal inicializaVetor
	
	lw $t2, ($sp)               #recupera valor da pilha
	addi $sp, $sp, 4            #ajusta pilha
	add $v0, $v0, $t2           #soma o valor de retorno com o valor armazenado
	
	jr $ra
	
	
	


									
