#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <stdbool.h>
#include <pthread.h>
#include <time.h>
#include <assert.h>

int main() {

unsigned char code[] = {
    0xff, 0x43, 0x00, 0xd1, // sub sp, sp, #16
    0xe0, 0x0f, 0x00, 0xb9, // str w0, [sp, #12]
    0xe1, 0x0b, 0x00, 0xb9, // str w1, [sp, #8]
    0xe8, 0x0f, 0x40, 0xb9, // ldr w8, [sp, #12]
    0xe9, 0x0b, 0x40, 0xb9, // ldr w9, [sp, #8]
    0x00, 0x7d, 0x09, 0x1b, // mul w0, w8, w9
    0xff, 0x43, 0x00, 0x91, // add sp, sp, #16
    0xc0, 0x03, 0x5f, 0xd6, // ret
    };

    pthread_jit_write_protect_np(false);
    void* mem = mmap(NULL, sizeof(code), PROT_WRITE | PROT_EXEC | PROT_READ,
            MAP_JIT | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    memcpy(mem, code, sizeof(code));
    __builtin___clear_cache((void *)mem, (void *)mem + sizeof(code));
    pthread_jit_write_protect_np(true);
    int (*func) () = mem;
    srand(time(NULL));
    for (int i = 0;i < 100;i++) {
        int r = rand();
        // printf("%d * %d = %d\n", 5, 11, func(5, 11));
        assert(func(i,r) == i * r);
    }
    munmap(mem, sizeof(code));
}
