.section .text
.global _start

_start:
    movl $0, %eax
    movl $1, %ebx
    movl $25, %ecx

fibonacci_loop:
    cmpl $0, %ecx       # Compare le cpt et 1
    jle exit            # Sortir si compteur <= 1

    movl %eax, %edx     # Sauvegarder Fn-1 (%eax) dans %edx

    addl %ebx, %eax     # Calculer Fn = Fn-1 + Fn-2
    movl %edx, %ebx     # Mettre à jour Fn-2 (%ebx) avec l'ancien Fn-1 (%edx)

    decl %ecx
    jmp fibonacci_loop

exit:
    movl $60, %eax
    xorl %edi, %edi
    syscall
