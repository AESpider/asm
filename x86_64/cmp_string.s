.section .data
    string1: .asciz "hello"     # null-terminated "hello"
    string2: .asciz "hello"

.section .text
.globl _start

_start:
    lea string1(%rip), %rsi     # load address of string1 into RSI (source)
    lea string2(%rip), %rdi     # load address of string2 into RDI (destination)

    cld                         # clear direction flag (forward scanning)
    movq $5, %rcx               # number of bytes to compare (5 for "hello")

    repe cmpsb                  # compare RCX bytes: compare (%rdi) with (%rsi)

    # If all compared bytes were equal, RCX == 0 and ZF == 1
    # If a mismatch occurred, RCX > 0 and ZF == 0
    je equal

not_equal:
    xor %rax, %rax              # set return value 0 (not equal)
    jmp exit

equal:
    movq $1, %rax               # set return value 1 (equal)

exit:
    movq $60, %rax
    xorq %rdi, %rdi
    syscall
