.global _main
.align 2

_main:
    mov x0, #1 // file descriptor of stdout
    adr x1, mystring // string to write
    mov x2, #4 // size of string to write
    mov x16, #4 // x8 = 4 write() syscall number
    svc 0 // invoke syscall

    mov x0, #0
    mov x16, #1 // exit() syscall number
    svc 0 // invoke syscall

mystring:   .ascii "Hi!\n"
