/* create the file "/tmp/pwn" and call exit(0). */

// as --64 -o create_file.o create_file.s && ld -o create_file create_file.o

.section .text
.globl _start

_start:
    /* JMP-CALL-POP technique to load the address of the string into RDI */
    jmp call_string

get_string:
    popq %rdi                   # RDI = address of "/tmp/pwn" (Arg 1: filename)

    /* 1) sys_creat(filename=RDI, mode=RSI) */
    xorq %rsi, %rsi             # RSI = 0
    movb $0xb6, %sil            # RSI = 0xB6 = 0666 (Arg 2: permissions)
    movb $85, %al               # RAX = 85 (sys_creat)
    syscall                    

    /* The syscall result (file descriptor) is returned in RAX */

    /* 2) sys_exit(status=RDI) */
    xorq %rdi, %rdi             # RDI = 0 (Arg 1: status)
    movb $60, %al               # RAX = 60 (sys_exit)
    syscall                     

call_string:
    call get_string
    .ascii "/tmp/pwn"           # no null terminator
