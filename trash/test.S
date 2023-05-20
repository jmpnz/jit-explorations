.text
.global _main
.align 4
_main:
stp x29, x30, [sp, #-32]!
str x28, [sp, #16]
mov x29, sp
sub sp, sp, #7, lsl #12
sub sp, sp, #1328
mov x0, sp
mov w1, wzr
mov x2, #30000
bl memset
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x8, [sp, #48]
  ldrb w0, [x8]
  bl putchar
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w10, [x9]
  mov w8, #-1
  add w8, w8, w10, uxtb
  strb w8, [x9]
  ldr x8, [sp, #48]
  ldrb w0, [x8]
  bl putchar
  ldr x8, [sp, #48]
  add x8, x8, #1
  str x8, [sp, #48]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x9, [sp, #48]
  ldrb w8, [x9]
  add w8, w8, #1
  strb w8, [x9]
  ldr x8, [sp, #48]
  ldrb w0, [x8]
  bl putchar
  ldr x8, [sp, #48]
  subs x8, x8, #1
  str x8, [sp, #48]
  ldr x8, [sp, #48]
  ldrb w0, [x8]
  bl putchar
  bl getchar
  ldr x8, [sp, #48]
  strb w0, [x8]
  ldr x8, [sp, #48]
  ldrb w0, [x8]
  bl putchar
add sp, sp, #7, lsl #12
add sp, sp, #1328
ldr x28, [sp, #16]
ldp x29, x30, [sp], #32
ret

