#include <sys/mman.h>

// gcc runner_shellcode.c -o runner_shellcode

unsigned char shellcode[] =
    "\x48\x31\xc0\x48\xbb\x2f\x62\x69\x6e\x2f\x73\x68\x00\x53\x48\x89"
    "\xe7\x50\x57\x48\x89\xe6\x48\x31\xd2\xb0\x3b\x0f\x05\xb0\x3c\x48"
    "\x31\xff\x0f\x05";

int main()
{
  void *exec = mmap(0, sizeof(shellcode),
                    PROT_READ | PROT_WRITE | PROT_EXEC,
                    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

  __builtin_memcpy(exec, shellcode, sizeof(shellcode));
  ((void (*)())exec)();

  return 0;
}