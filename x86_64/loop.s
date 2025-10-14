.global _start

# as loop.s -o loop.o && ld loop.o -o loop

_start:
    movl $10, %eax      # Set loop counter to 10

loop_start:
    decl %eax
    jz exit             # If counter is zero, jump to exit
    jmp loop_start

exit:
    movl $60, %eax      # syscall number for exit
    xor %edi, %edi      # exit code 0
    syscall
