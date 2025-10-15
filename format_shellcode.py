#!/usr/bin/python3
import sys

if len(sys.argv) != 2:
    print(f"Usage: {sys.argv[0]} <shellcode.bin>")
    sys.exit(1)

with open(sys.argv[1], "rb") as f:
    print(''.join(f'\\x{b:02x}' for b in f.read()), end='')