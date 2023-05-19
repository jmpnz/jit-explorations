#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>

int hello_world() {
  printf("Hello world!\n");
  return 13;
}

const int true = -1, false = 0;
int size = 4096;

enum ZK { z = 0, k = 1 << 29 };
enum Shift { lsl = 0b00, asr = 0b10 };
enum Cond {
  eq = 0b0000,
  ne = 0b0001,
  ge = 0b1010,
  lt = 0b1011,
  gt = 0b1100,
  le = 0b1101,
  al = 0b1110
};

void print_binary(uint64_t n) {
  for (int b = 31; b >= 0; --b)
    printf("%c", (((n >> b) & 1) == 0 ? '0' : '1'));
  printf("\n");
}

const int32_t ret() { return 0b11010110010111110000001111000000; }

// movz and movk
const int32_t mov_wide_immediate(enum ZK zk, int x, int imm, int shift) {
  return (0b110100101 << 23) + zk + (shift << (21 - 4)) + (imm << 5) + x;
}

const int32_t movz(int x, int imm, int shift) {
  return mov_wide_immediate(z, x, imm, shift);
}

const int32_t movk(int x, int imm, int shift) {
  return mov_wide_immediate(k, x, imm, shift);
}

// ORR <Xd>, <Xn>, <Xm>{, <shift> #<amount>}
const int32_t orr_shifted_register(int rd, int rn, int rm, enum Shift shift,
                                   int imm) {
  return (0b10101010 << 24) + (shift << 22) + (rm << 16) + (imm << 10) +
         (rn << 5) + rd;
}

// MOV <Xd>, <Xm>{, <shift> #<amount>}
const int32_t mov_shifted_register(int rd, int rm, enum Shift shift, int imm) {
  return (0b10101010 << 24) + (shift << 22) + (rm << 16) + (imm << 10) +
         (0b11111 << 5) + rd;
}

// MOV <Xd>, <Xm>{, <shift> #<amount>}
const int32_t mov_register(int rd, int rm) {
  return mov_shifted_register(rd, rm, lsl, 0);
}

// https://developer.arm.com/documentation/ddi0596/2020-12/SIMD-FP-Instructions/FMOV--general---Floating-point-Move-to-or-from-general-purpose-register-without-conversion-?lang=en
const int32_t fmov_general(int sf, int ftype, int rmode, int opcode, int rd,
                           int rn) {
  return (0b00011110001 << 21) + (sf << 31) + (ftype << 22) + (rmode << 19) +
         (opcode << 16) + (rn << 5) + rd;
}

// fmov <dd>, <xn>
const int32_t fmov_dx(int rd, int rn) {
  return fmov_general(1, 1, 0, 0b111, rd, rn);
}

// cmp xn, xm, lsl/asr shift
const int32_t cmp_shifted_register(int rn, int rm, enum Shift shift, int imm) {
  return 0b11101011000000000000000000011111 + (shift << 22) + (rm << 16) +
         (imm << 10) + (rn << 5);
}

// xn, xm
const int32_t cmp_register(int rn, int rm) {
  return cmp_shifted_register(rn, rm, lsl, 0);
}

// b +/-1MiB
const int32_t b(enum Cond cond, int64_t imm) {
  imm = ((uint64_t)imm & ((1 << 19) - 1));
  return (0b01010100 << 24) + (imm << 5) + cond;
}

// bl +/- 128MiB
const int32_t bl(int imm) {
  return (0b100101 << 26) + ((uint64_t)imm & ((1 << 26) - 1));
}

// br xn
const int32_t br(int r) { return (0b1101011000011111 << 16) + (r << 5); }

// blr xn
const int32_t blr(int r) { return (0b1101011000111111 << 16) + (r << 5); }

void mov_uint64(int32_t **code, int r, uint64_t v) {
  for (int s = 0; s < 4; ++s)
    *(*code)++ = mov_wide_immediate((s == 0 ? z : k), r,
                                    ((uint64_t)v >> (16 * s)) & 0xffff, 16 * s);
}

// Allocate an executable buffer of size bytes.
int32_t *alloc(int size) {
  printf("PROT_READ = %lld\n", (int64_t)PROT_READ);
  printf("PROT_WRITE = %lld\n", (int64_t)PROT_WRITE);
  printf("PROT_EXEC = %lld\n", (int64_t)PROT_EXEC);
  printf("MAP_JIT = %lld\n", (int64_t)MAP_JIT);
  printf("MAP_PRIVATE = %lld\n", (int64_t)MAP_PRIVATE);
  printf("MAP_ANONYMOUS = %lld\n", (int64_t)MAP_ANONYMOUS);
  printf("MAP_FAILED = %lld\n", (int64_t)MAP_FAILED);
  int prot = PROT_READ | PROT_WRITE | PROT_EXEC;
  int map = MAP_JIT | MAP_PRIVATE | MAP_ANONYMOUS;
  int32_t *p = (int32_t *)mmap(NULL, size, prot, map, -1, 0);
  if (p == MAP_FAILED || !p) {
    printf("nmap failed\n");
    exit(1);
  }
  return p;
}

void codegen(int32_t *code) {
  int64_t hw = (int64_t)&hello_world;

  mov_uint64(&code, 0, hw);
  *code++ = br(0);

  int64_t c = (int64_t)code;
  printf("Branch distance: %lld\n", (hw - c) / 4);
  *code++ = b(al, (hw - c) / 4);

  *code++ = movz(0, 42, 0); // mov x0, #42
  printf("%#08x\n", movz(0, 42,0));
  *code++ = ret();          // ret
}

int main(int argc, char *argv[]) {
  if (argc != 2) {
    printf("I need an int argument\n");
    return 1;
  }
  int64_t arg = atoi(argv[1]);
  printf("Allocating executable buffer...\n");
  int32_t *p = alloc(size);
  printf("Generating machine code...\n");
  pthread_jit_write_protect_np(false);
  codegen(p);
  __builtin___clear_cache((char *)p, (char *)p + size);
  pthread_jit_write_protect_np(true);
  printf("Executing...\n");
  int64_t (*f)(int64_t) = (int64_t(*)(int64_t))p;
  int64_t r = f(arg);
  printf("f(%lld) = %lld\n", arg, r);
  return 0;
}
