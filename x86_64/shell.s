.section .text
.globl _start

_start:
    # Préparer les arguments pour execve
    subq $16, %rsp         	  # Allouer de l'espace sur la pile

    # Adresse de "/bin/sh"
    movq $0x68732f6e69622f, %rax  # "/bin/sh" en hexadécimal
    pushq %rax
    movq %rsp, %rdi        # 1er argument: chemin

    pushq $0               # Terminateur de liste
    pushq %rdi             # Pointeur vers "/bin/sh"
    movq %rsp, %rsi        # 2ème argument: argv

    xorq %rdx, %rdx        # 3ème argument: envp = NULL

    # Appel système execve
    movq $59, %rax         # Numéro syscall execve
    syscall

exit:
    movq $60, %rax
    movq $1, %rdi
    syscall
