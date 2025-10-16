/* cat .secret */

.section .text
.globl _start

// as --64 -o cat_file.o cat_file.s && ld -o cat_file cat_file.o

_start:
    jmp     filename

main:
    pop     %rdi                # rdi = ".secret"
    
    // open(".secret", O_RDONLY)
    cdq                         # rdx = 0
    movb    $2, %al             # sys_open
    syscall

    // read(fd, rsp-32, 32)
    xchg    %eax, %edi          # edi = fd
    push    %rdx                # buffer
    mov     %rsp, %rsi          # rsi = buffer
    movb    $32, %dl            # rdx = 32 (read bytes) 
    xor     %eax, %eax
    syscall                     # sys_read

    // write(1, buffer, bytes_read)
    xchg    %eax, %edx          # edx = bytes read
    movb    $1, %dil            # stdout
    movb    $1, %al             # sys_write
    syscall

    // exit(0)
    xor     %edi, %edi          # exit(0)
    movb    $60, %al
    syscall

filename:
    call    main
    .ascii  ".secret"
