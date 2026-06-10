.data
	msg_entrada:  .asciiz "Digite um numero (1 < N <= 50000): "
 	msg_invalido: .asciiz "Valor invalido! Tente novamente.\n"
	msg_resultado:.asciiz "O primeiro primo anterior a "
	msg_e:        .asciiz " e': "
	msg_newline:  .asciiz "\n"

        .text
        .globl main
main:
ler_numero:
        li   $v0, 4                  
        la   $a0, msg_entrada
        syscall

        li   $v0, 5                
        syscall
        move $t0, $v0                

 
        bgt  $t0, 1, verifica_max
        j    invalido

verifica_max:
    
        li   $t1, 50000
        ble  $t0, $t1, entrada_valida
invalido:
        li   $v0, 4
        la   $a0, msg_invalido
        syscall
        j    ler_numero

entrada_valida:
        sub  $t2, $t0, 1           

busca_primo:
       
        move $a0, $t2
        jal  is_prime

        beq  $v0, 1, encontrou     
        sub  $t2, $t2, 1            
        j    busca_primo


encontrou:
        li   $v0, 4
        la   $a0, msg_resultado
        syscall

        li   $v0, 1                
        move $a0, $t0
        syscall

        li   $v0, 4
        la   $a0, msg_e
        syscall

        li   $v0, 1                 
        move $a0, $t2
        syscall

        li   $v0, 4
        la   $a0, msg_newline
        syscall

        li   $v0, 10               
        syscall


is_prime:
       
        sub  $sp, $sp, 12
        sw   $ra, 0($sp)
        sw   $s0, 4($sp)
        sw   $s1, 8($sp)

        move $s0, $a0              

      
        li   $v0, 0
        ble  $s0, 1, fim_is_prime

       
        li   $v0, 1
        beq  $s0, 2, fim_is_prime

        
        li   $v0, 0
        andi $t3, $s0, 1        
        beq  $t3, 0, fim_is_prime

       
        li   $s1, 3                 

loop_divisor:
       
        mul  $t3, $s1, $s1         
        bgt  $t3, $s0, eh_primo


        div  $s0, $s1
        mfhi $t3                   
        beq  $t3, 0, nao_primo

        add  $s1, $s1, 2            
        j    loop_divisor

eh_primo:
        li   $v0, 1
        j    fim_is_prime

nao_primo:
        li   $v0, 0

fim_is_prime:
 
        lw   $ra, 0($sp)
        lw   $s0, 4($sp)
        lw   $s1, 8($sp)
        add  $sp, $sp, 12
        jr   $ra
