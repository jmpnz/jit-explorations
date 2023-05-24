// Brainf*ck interpreter in glorious aarch64
// Notes :
// Wide registers : 4 bytes long
// eXtended registers : 8 bytes long
// mov dst, src : mov only operates on registers and immediates
// ldr dst, [src] : load 8 byte at memory address in src into dst
// str src, [dst] : store 8 byte in register src at memory address in dst
// Variants :
// strb : stores a 1 byte value
// strh : stores a 2 byte value
// str : stores 4 or 8 bytes depending on whether it's an w or x register
// Arithmetic operations
// add dst, op1, op2 : dst <- op1 + op2
// sub dst, op1, op2 : dst <- op1 - op2
// Comparisons
// cmp op1, op2 : compares and sets flags in NZCV register
// Unconditional control flow
// b <label> : unconditionally branch to <label>
// Conditional control flow, condition is given by flag in NZCV register
// b.eq <label> Branch to label if equal
// b.ne <label> Branch to label if not equal
// b.gt <label> Branch to label if greater
// b.ge <label> Branch to label if greater or equal
// b.lt <label> Branch to label if lesser
// b.le <label> Branch to label if lesser or equal
// Syscalls
// svc 0 : Invoke Supervisor call to make syscall
// Syscall number goes in x8 arguments in x0, x1, x2
.data

.equ SYS_EXIT, 93
.equ SUCCESS, 0

.equ SYS_WRITE, 64
.equ STDOUT, 1

.equ SYS_READ, 63
.equ STDIN, 0

.bss

.lcomm ARRAY, 30000 // Machine tape

.text

.global _start

_start:
    ldr x19, =ARRAY // Prologue

    add x19, x19, 1
    add x19, x19, 2

    sub x19, x19, 1
    sub x19, x19, 2

    ldrb w20, [x19]
    add w20, w20, 1
    strb w20, [x19]

    ldrb w20, [x19]
    add w20, w20, 2
    strb w20, [x19]

    ldrb w20, [x19]
    sub w20, w20, 1
    strb w20, [x19]

    ldrb w20, [x19]
    sub w20, w20, 2
    strb w20, [x19]

    // read byte from stdin & store at pointer

    // ,
    mov x8, SYS_READ
    mov x0, STDIN
    mov x1, x19
    mov x2, 1
    svc 0

    // ,,
    mov x8, SYS_READ
    mov x0, STDIN
    mov x1, x19
    mov x2, 1
    svc 0
    mov x8, SYS_READ
    mov x0, STDIN
    mov x1, x19
    mov x2, 1
    svc 0

    // write byte at pointer to stdout

    // .
    mov x8, SYS_WRITE
    mov x0, STDOUT
    mov x1, x19
    mov x2, 1
    svc 0

    // ..
    mov x8, SYS_WRITE
    mov x0, STDOUT
    mov x1, x19
    mov x2, 1
    svc 0
    mov x8, SYS_WRITE
    mov x0, STDOUT
    mov x1, x19
    mov x2, 1
    svc 0

    // loops

    // [
    ldrb w20, [x19]
    cmp w20, 0
    b.eq LOOP_END_1
    LOOP_START_0:

    // ]
    ldrb w20, [x19]
    cmp w20, 0
    b.ne LOOP_START_0
    LOOP_END_1:


    // Epilogue
    mov x8, SYS_EXIT
    mov x0, SUCCESS
    svc 0

