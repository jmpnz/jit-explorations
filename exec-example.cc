#include <cstdint>
#include <cstring>
#include <iostream>
#include <string>
#include <vector>

// unix
#include <libkern/OSCacheControl.h>
#include <pthread.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>

// Example function that generates ARM assembly code
void generateAssembly(std::vector<uint8_t> &assembly) {
  // Example ARM assembly code for a simple function that adds two integers
  uint8_t addAssembly[] = {
      0xE0, 0x00, 0x00, 0x9A, // mov x0, x0 (no-op)
      0xE1, 0x03, 0x00, 0xAA, // add x1, x1, x2
      0xC0, 0x03, 0x5F, 0xD6, // ret
  };
  uint8_t mulAssembly[] = {
      0xE0, 0x00, 0x00, 0x9A, // mov x0, x0 (no-op)
      0xE1, 0x03, 0x00, 0xAA, // add x1, x1, x2
      0xC0, 0x03, 0x5F, 0xD6, // ret
  };
  assembly.insert(assembly.end(), addAssembly,
                  addAssembly + sizeof(addAssembly));
}

typedef struct JITContext {
public:
  void *Allocate(size_t size);
  void Load(void *dst, uint8_t *src, size_t size);

private:
  int MMAPProtection = PROT_EXEC | PROT_READ | PROT_WRITE;
  int MMAPFlags = MAP_JIT | MAP_PRIVATE | MAP_ANONYMOUS;
  int fd = -1;
  int offset = 0;
} JITContext;

void *JITContext::Allocate(size_t size) {
  void *addr = mmap(nullptr, size, this->MMAPProtection, this->MMAPFlags,
                    this->fd, this->offset);
  if (addr == MAP_FAILED) {
    std::cerr << "Failed to allocate executable memory" << std::endl;
    return nullptr;
  }

  pthread_jit_write_protect_np(false);
  sys_icache_invalidate(addr, size);
  return addr;
}

void JITContext::Load(void *dst, uint8_t *src, size_t size) {
  std::memcpy(dst, src, size);
  pthread_jit_write_protect_np(true);
  sys_icache_invalidate(dst, size);
}

int main() {
  // Generate assembly code
  std::vector<uint8_t> assembly;
  generateAssembly(assembly);

  // Get the alignment requirements for ARM CPU
  size_t alignment = 8;

  // Calculate the size of the executable memory, including alignment padding
  size_t size = assembly.size();
  size_t alignedSize = (size + alignment - 1) & ~(alignment - 1);
  // Allocate executable memory with proper alignment
  //
  // void *executableMemory;
  // int result = posix_memalign(&executableMemory, alignment, alignedSize);
  // if (result != 0) {
  //   std::cerr << "Failed to allocate executable memory" << std::endl;
  //   return 1;
  // }
  //
  //
  //  void *executableMemory =
  //      mmap(nullptr, size, PROT_EXEC | PROT_READ | PROT_WRITE,
  //           MAP_JIT | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
  //  if (executableMemory == MAP_FAILED) {
  //    std::cerr << "Failed to allocate executable memory" << std::endl;
  //    return 1;
  //  }
  //
  // Copy the assembly code to the executable memory
  //   std::memcpy(executableMemory, assembly.data(), size);
  //   pthread_jit_write_protect_np(1);
  //   sys_icache_invalidate(executableMemory, size);
  //
  //
  JITContext ctx;

  void *executableMemory = ctx.Allocate(size);
  std::cout << "memcpy assembly to executable block" << std::endl;
  printf("%lu\n", sizeof(executableMemory));
  std::cout << "define function ptr @" << executableMemory << std::endl;
  // Load assembly code for execution.
  ctx.Load(executableMemory, assembly.data(), size);
  // Define a function pointer with the same signature as the generated
  // function
  typedef int (*AddFunction)(int, int);
  AddFunction add = (AddFunction)(executableMemory);

  std::cout << "calling add(2,3) at address: " << add << std::endl;
  // Call the generated function
  int result = add(2, 3);
  std::cout << "Result: " << result << std::endl;

  // Clean up: unmap the executable memory
  munmap(executableMemory, size);

  return 0;
}
