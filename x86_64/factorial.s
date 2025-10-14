.section .text
.global _start

_start:
    movl $8, %ecx       # le nombre dont on calcule la factorielle
    movl $1, %eax

factorial_loop:
    imull %ecx, %eax
    loop factorial_loop # Décrémenter %ecx et répéter jusqu'à %ecx == 0

exit:
    movl $60, %eax      # numéro d'appel système pour exit
    xorl %edi, %edi     # code de sortie 0
    syscall
