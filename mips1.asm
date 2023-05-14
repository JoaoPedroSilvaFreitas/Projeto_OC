.eqv size 20                        #define size

.data
	vet: 	
		.align 2
		.space 80           #20 x 4 bits
.data
	barra_n:
		.asciiz "\n "
		.align 0
	
.text
main:
	la $s0, vet                 #armazena endereço do vet
	li $a1, size                #armazena size no registrador a1
	li $a2, 71                  #armazena 71 no registrador a2
	move $a0, $s0               #armazena vet em $a0 para chamar função
	jal inicializaVetor 	    #(vet, SIZE, 71);
	move $s1 , $v0              #soma = inicializaVetor
	
	la $s0, vet                 #armazena endereço do vet
	li $a1, size                #armazena size no registrador a1
	move $a0, $s0               #armazena vet em $a0 para chamar função
	jal ordenaVetor		    #(int vet[], int n)
	
	la $s0, vet                 #armazena endereço do vet
	li $a1, size                #armazena size no registrador a1
	move $a0, $s0               #armazena vet em $a0 para chamar função
	jal imprimeVetor	    #(int vet[], int tam)
	
	
	la $s0, vet                 #armazena endereço do vet
	add $a0, $s0, 0             #$a0 = &vet[0] aponta para posição 0
	li $t0, size                #armazena size em $t0
	mul $t0, $t0, 4             #calcula o valor de size em bits
	add $a1, $s0, $t0           #$a0 = &vet[size] aponta para posição size
	jal zeraVetor               #zeraVetor(int *inicio, int *fim)
	
	la $s0, vet                 #armazena endereço do vet
	li $a1, size                #armazena size no registrador a1
	move $a0, $s0               #armazena vet em $a0 para chamar função
	jal imprimeVetor	    #(int vet[], int tam)
			
zeraVetor:                          #zeraVetor(int *inicio, int *fim)
	WHILE:
		slt $t0, $a0, $a1                             #*inicio < *fim
		beq $t0 , $zero , FIMwhile                    #se falso vai para FIMforPRT
		li $t1 , 0                                    #armazena 0 em $t1
		sw $t1, ($a0)                                 #armazena $t1 em *inicio
		addi $a0, $a0, 4	                      #inicio++
		j WHILE                                       #continua while
	FIMwhile:
	jr $ra
	
imprimeVetor:                       #imprimeVetor(int vet[], int tam)
	li $t0, 0		    #int i = 0
	
	FORprt:
	
		slt $t1 , $t0 , $a1                            #testa se i < tam
		beq $t1 , $zero , FIMforPRT                    #se falso vai para FIMforPRT
		sll $t3, $t1, 2                                #$t3 = i * 4 calcula bits da posição i
		add $t3, $a0, $t3                              #$t3 = &vet[i] aponta para posição i
		lw $t4 , ($t3)                                 #armazena valor na posição vet[i] em $t4 
		syscall                                        #imprime valor do vet[i]
		addi $t0, $t0, 1	                       #i++
		
	FIMforPRT:
	
	la $t5, barra_n             #armazena endereço do \n
	syscall                     #imprime \n
	jr $ra
	
ordenaVetor:                        #ordenaVetor(int vet[], int n)
	move $s0, $a0               #armazena vetor no registrador s0
	li $s2, 0                   #int i;
	li $s3, 0                   #int j;
	li $s4, 0                   #int min_idx;
	
	FOR:	
		addi $a1, $a1, -1	                       #n-1
		slt $t0 , $s2 , $a1                            #testa se i < n-1
		beq $t0 , $zero , FIMfor                       #se falso vai para FIM
		addi $s4, $s2, 0                               #min_idx = i
		
		FOR2:	
			addi $s3, $s2, 1		       #j = i + 1
			addi $a1, $a1, 1	               #n
			slt $t1 , $s3 , $a1                    #testa se j < n
			beq $t1 , $zero , FIM2                 #se falso vai para FIM2
			
			sll $t2, $s3, 2                        #$t2 = j * 4 calcula bits da posição j
			add $t2, $s0, $t2                      #$t2 = &vet[j] aponta para posição j
			
			sll $t3, $s4, 2                        #$t3 = min_idx * 4 calcula bits da posição min_idx
			add $t3, $s0, $t3                      #$t3 = &vet[min_idx] aponta para posição min_idx
			
			lw $s5 , ($t2)                        #armazena valor na posição vet[j] em $s5
			lw $s6 , ($t3)                        #armazena valor na posição vet[min_idx] em $s6
			
			slt $t4, $s5, $s6                      #if (vet[j] < vet[min_idx])
			bne $t4, $zero , FIMif                 #verifica se não é menor
			addi $s4, $s3, 0                       #min_idx = j
			FIMif:
			
			addi $s3, $s3, 1                       #j++
			j FOR2                                 #volta para FOR2
		FIM2:
		
			bne $s4 , $s2 , FIMif2                 #if (min_idx != i)
			
			sll $t2, $s2, 2                        #$t2 = i * 4 calcula bits da posição i
			add $t2, $s0, $t2                      #$t2 = &vet[i] aponta para posição i
			
			sll $t3, $s4, 2                        #$t3 = min_idx * 4 calcula bits da posição min_idx
			add $t3, $s0, $t3                      #$t3 = &vet[min_idx] aponta para posição min_idx
			
			move $a0, $t3                          #armazena &vet[min_idx] em a0
			move $a1, $t4                          #armazena &vet[i] em a0
			
			jal troca                              #(&vet[min_idx], &vet[i])	
		FIMif2:
		
		addi $t0, $t0, 1                               #i++
		j FOR                                          #volta para FOR
	FIMfor:
	jr $ra
	
	
troca:                              #troca(int *a, int *b)
	beq $a0, $a1, FIMtroca      #testa se a == b
	addi $t0, $a0, 0            #aux = a
	move $a0, $a1               #a = b
	move $a1, $t0               #b = aux
	FIMtroca:              
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
	
	move $s2, $v0               #novoValor = valorAleatorio
	addi $t0, $t0, -4           #tamanho - 1
	add $s0, $s0, $t0           #apontando para vetor[tamanho - 1]
	sw $s2, ($s0)		    #vetor[tamanho - 1] = novoValor;
	
	move $a1, $t0               #armazena tamanho do registrdor $a1 para chamar função
	move $a2, $a0               #armazena ultimoValor no registrador $a2 para chamar função
	
	addi $sp, $sp, -4           #aloca pilha
	add $v0, $v0, $s2           #novoValor + inicializaVetor
	sw $v0, ($sp)               #armazena retorno na pilha
	
	jal inicializaVetor
	
	lw $t2, ($sp)               #recupera valor da pilha
	addi $sp, $sp, 4            #ajusta pilha
	add $v0, $v0, $t2           #soma o valor de retorno com o valor armazenado
	
	jr $ra
	
	
	


									
