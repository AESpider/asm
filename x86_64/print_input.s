.section .text
.globl _start

_start:
    # read: read 1 byte from stdin
    movq $0, %rax          # syscall: read (0)
    movq $0, %rdi          # fd = 0 (stdin)
    subq $1, %rsp          # allocate 1 byte on stack
    leaq (%rsp), %rsi      # buffer = rsp
    movq $1, %rdx          # count = 1
    syscall

    # write: write that 1 byte to stdout
    movq $1, %rax          # syscall: write (1)
    movq $1, %rdi          # fd = 1 (stdout)
    leaq (%rsp), %rsi      # buffer = rsp
    movq $1, %rdx          # count = 1
    syscall

    addq $1, %rsp          # restore stack pointer (undo subq $1, %rsp)

    # exit: exit(0)
    movq $60, %rax         # syscall: exit (60)
    xorq %rdi, %rdi        # status = 0
    syscall
