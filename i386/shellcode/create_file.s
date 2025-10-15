/* create the file "/tmp/pwn" and call exit(42). */

// as --32 -o create_file.o create_file.s && ld -m elf_i386 -o create_file create_file.o

.section .text
.globl _start

_start:
    /* JMP-CALL-POP technique to load the address of the string into EBX */
    jmp call_string

get_string:
    popl %ebx                   # EBX = address of "/tmp/pwn" (Arg 1: filename)

    /* 1) sys_creat(filename=EBX, mode=ECX) */
    xorl %ecx, %ecx             # ECX = 0
    movb $0xb6, %cl             # ECX = 0xB6 = 0666 (Arg 2: permissions)
    movb $8, %al                # EAX = 8 (sys_creat)
    int $0x80                   

    /* The syscall result (file descriptor) is returned in RAX */

    /* 2) sys_exit(status=EBX) */
    xorl %ebx, %ebx             # EBX = 0 (Arg 1: status)
    movb $1, %al                # EAX = 1 (sys_exit)
    int $0x80                   

call_string:
    call get_string
    .ascii "/tmp/pwn"           # no null terminator
