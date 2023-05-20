/**
 * Brainf*ck JIT based on Nick Desaulniers blog post :
 * https://nickdesaulniers.github.io/blog/2015/05/25/interpreter-compiler-jit/
 * adapted for ARM64
 *
 */
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <sys/mman.h>
#include <pthread.h>

#define GUARD(expr) assert(!(expr))
#define STACKSIZE 100

struct stack {
    int size;
    int items[STACKSIZE];
};

int stack_push (struct stack* const p, const int x) {
  if (p->size == STACKSIZE) {
    return -1;
  } else {
    p->items[p->size++] = x;
    return 0;
  }
}

int stack_pop (struct stack* const p, int* x) {
  if (p->size == 0) {
    return -1;
  } else {
    *x = p->items[--p->size];
    return 0;
  }
}

void compile(const char* const file_contents) {
    int nbrackets = 0;
    int matching_brackets = 0;
    struct stack stack = { .size = 0, .items = { 0 }};
    const char* prologue = {
        ".text\n"
        ".global _main\n"
        "_main:\n"
        "stp x29, x30, [sp, #-32]!\n"
        "str x28, [sp, #16]\n"
        "mov x29, sp\n"
        "sub sp, sp, #7, lsl #12\n"
        "sub sp, sp, #1328\n"
        "mov x0, sp\n"
        "mov w1, wzr\n"
        "mov x2, #30000\n"
        "bl memset\n"
    };
    puts(prologue);

    for (unsigned long i = 0; file_contents[i] != '\0'; ++i) {
        switch (file_contents[i]) {
            case '>': {
                puts("  ldr x8, [sp, #48]");
                puts("  add x8, x8, #1");
                puts("  str x8, [sp, #48]");
                break;
            }
            case '<': {
                puts("  ldr x8, [sp, #48]");
                puts("  subs x8, x8, #1");
                puts("  str x8, [sp, #48]");
                break;
            }
            case '+': {
                puts("  ldr x9, [sp, #48]");
                puts("  ldrb w8, [x9]");
                puts("  add w8, w8, #1");
                puts("  strb w8, [x9]");
                break;
            }
            case '-': {
                puts("  ldr x9, [sp, #48]");
                puts("  ldrb w10, [x9]");
                puts("  mov w8, #-1");
                puts("  add w8, w8, w10, uxtb");
                puts("  strb w8, [x9]");
                break;
            }
            case '.': {
                puts("  ldr x8, [sp, #48]");
                puts("  ldrb w0, [x8]");
                puts("  bl putchar");
                break;
            }
            case ',': {
                puts("  bl getchar");
                puts("  ldr x8, [sp, #48]");
                puts("  strb w0, [x8]");
                break;
            }

        }

    }

    const char* epilogue = {
        "add sp, sp, #7, lsl #12\n"
        "add sp, sp, #1328\n"
        "ldr x28, [sp, #16]\n"
        "ldp x29, x30, [sp], #32\n"
        "ret\n"
    };
    puts(epilogue);

}

void err (const char* const msg) {
  fprintf(stderr, "%s\n", msg);
  exit(1);
}

char* read_file (const char* const filename) {
  if (filename == NULL) {
    return NULL;
  }

  FILE* fp = fopen(filename, "r");
  if (fp == NULL) {
    return NULL;
  }

  GUARD(fseek(fp, 0, SEEK_END));
  long file_size = ftell(fp);
  rewind(fp);
  size_t code_size = sizeof(char) * file_size;
  char* code = malloc(code_size);
  if (code == NULL) {
    return NULL;
  }
  fread(code, 1, file_size, fp);
  GUARD(fclose(fp));
  return code;
}

void interpret(const char* const input) {
    // Machine tape.
    unsigned char tape[30000] = { 0 };
    // Set the pointer to the start of the tap.
    unsigned char* ptr = tape;
    char current_char;

    for (int i = 0; (current_char = input[i]) != '\0'; ++i) {
        switch (current_char) {
            case '>':
                ++ptr;
                break;
            case '<':
                --ptr;
                break;
            case '+':
                ++(*ptr);
                break;
            case '-':
                --(*ptr);
                break;
            case '.':
                putchar(*ptr);
                break;
            case ',':
                *ptr = getchar();
                break;
            case '[':
              if (!(*ptr)) {
                int loop = 1;
                while (loop > 0) {
                  unsigned char current_char = input[++i];
                  if (current_char == ']') {
                    --loop;
                  } else if (current_char == '[') {
                    ++loop;
                  }
                }
              }
              break;
            case ']':
              if (*ptr) {
                int loop = 1;
                while (loop > 0) {
                  unsigned char current_char = input[--i];
                  if (current_char == '[') {
                    --loop;
                  } else if (current_char == ']') {
                    ++loop;
                  }
                }
              }
              break;
            default:
                ptr++;
                break;
        }
    }

    printf("I am done interpreting\n");
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        err("Usage : bf-jit file.bf\n");
    }
    char* file_contents = read_file(argv[1]);
    if (file_contents == NULL) err("Couldn't open file");
    // interpret(file_contents);
    compile(file_contents);
    free(file_contents);
}
