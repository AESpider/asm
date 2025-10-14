.section .data
    radius: .double 10.0           # Le rayon du cercle

.section .text
.global _start

_start:
    finit                   # Initialise le FPU

    fldl radius            # Charge r dans st(0)
    fmul %st(0), %st(0)    # st(0) = r² (r * r)
    fldpi                  # Charge π dans st(0), r² passe en st(1)
    fmulp                  # st(0) = π * r², puis pop

    # Résultat dans st(0) = aire du cercle

exit:
    movq $60, %rax
    xor %rdi, %rdi
    syscall
