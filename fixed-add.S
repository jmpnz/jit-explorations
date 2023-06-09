.global _start

_start:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq $10, -8(%rbp)
    negq -8(%rbp)
    movq -8(%rbp), %rax
    addq $52, %rax
    addq $16, %rax
    popq %rbp
    retq
