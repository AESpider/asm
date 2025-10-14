#include <stdlib.h>

// gcc -o loop loop.c

int main(void)
{
  __asm__ volatile(
      "movl $10, %%eax\n\t" // Initialize eax to 10

      "loop_start:\n\t"        // Loop start label
      "    decl %%eax\n\t"     // Decrement eax
      "    jz exit\n\t"        // If eax == 0, jump to exit
      "    jmp loop_start\n\t" // Otherwise, jump back to loop_start

      "exit:\n\t"   // Exit label
      :             // No outputs
      :             // No inputs
      : "eax", "cc" // Tell compiler these are clobbered
  );

  return EXIT_SUCCESS;
}
