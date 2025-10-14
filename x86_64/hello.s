.section .data
msg:
	.asciz "Hello World!\n"
	len = .-msg                  # Longueur de la chaine

.section .text
.globl _start

_start:
    movq $1, %rdi           # Premier argument: fichier (stdout, numéro 1)
    leaq msg(%rip), %rsi    # Deuxième argument: adresse de la chaîne
    movq $len, %rdx         # Troisième argument: longueur de la chaîne

    movq $1, %rax	          # Numéro de l'appel système: sys_write
    syscall                 # Interruption pour passer au noyau

exit:
    movq $1, %rax
    xorq %rbx, %rbx
    int $0x80
