// A simple JIT for BF, without optimizations - translates BF operations to
// assembly instructions.
// JIT code based on Eli Bendersky's simplejit.cpp
#include <fstream>
#include <iomanip>
#include <iostream>
#include <vector>
#include <stack>
#include <cstdio>
#include <cassert>
#include <cstring>
#include <limits>
#include <sys/mman.h>

namespace {

// Allocate memory with read and write permissions using `mmap`.
void* allocRWXMemory(size_t size) {
  void* ptr =
      mmap(0, size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
  if (ptr == (void*)-1) {
    perror("mmap");
    return nullptr;
  }
  return ptr;
}

// Mark memory region as executable.
int markExecMemory(void* m, size_t size) {
  if (mprotect(m, size, PROT_READ | PROT_EXEC) == -1) {
    perror("mprotect");
    return -1;
  }
  return 0;
}

}

// Cache to store JIT compiled code, the cache allocates a memory
// region with proper permissions and copies code to the created region.
class JitCache {
public:
  JitCache(const std::vector<uint8_t>& code);
  ~JitCache();

  // Return a pointer to the program memory we want to execute.
  void* programMemory() {
    return programMemory_;
  }

  // Return program size.
  size_t programSize() {
    return programSize_;
  }

private:
  void* programMemory_ = nullptr;
  size_t programSize_ = 0;
};

// Context that is used to build the Jit code we want to execute.
// The context handles encoding passed instructions in little-endian.
class JitContext {
public:
  JitContext() = default;

  void emitByte(uint8_t v);

  // emits a sequence of consecutive bytes.
  void emitBytes(std::initializer_list<uint8_t> seq);

  void emitUint32(uint32_t v);
  void emitUint64(uint64_t v);

  // replaces the byte at 'offset' with 'v'.
  void replaceByteAtOffset(size_t offset, uint8_t v);

  // replaces the 32-bit word at 'offset' with 'v'.
  void replaceUint32AtOffset(size_t offset, uint32_t v);

  // return code size.
  size_t size() const {
    return code_.size();
  }
  // return view to the code to execute.
  const std::vector<uint8_t>& code() const {
    return code_;
  }

private:
  std::vector<uint8_t> code_;
};

// Build a jit cache for the code we want to execute.
JitCache::JitCache(const std::vector<uint8_t>& code) {
  programSize_ = code.size();
  programMemory_ = allocRWXMemory(programSize_);
  // Handle `nullptr` on allocation.
  if (programMemory_ == nullptr) {
    printf("unable to allocate writable memory");
  }

  // Copy code to execute to executable memory region.
  memcpy(programMemory_, code.data(), programSize_);
  if (markExecMemory(programMemory_, programSize_) < 0) {
    printf("unable to mark memory as executable");
  }
}

// Destructor frees memory using `munmap`.
JitCache::~JitCache() {
  if (programMemory_ != nullptr) {
    if (munmap(programMemory_, programSize_) < 0) {
      perror("munmap");
      printf("unable to unmap memory");
    }
  }
}

// emit a single byte instruction.
void JitContext::emitByte(uint8_t v) {
  code_.push_back(v);
}

// emit a sequence of byte instructions (since instructions can be longer
// than a single byte).
void JitContext::emitBytes(std::initializer_list<uint8_t> seq) {
  for (auto v : seq) {
    emitByte(v);
  }
}

// swaps byte at `offset` with byte value `v`.
void JitContext::replaceByteAtOffset(size_t offset, uint8_t v) {
  assert(offset < code_.size() && "replacement fits in code");
  code_[offset] = v;
}

// swaps a 4 bytes value at `offset` with value `v`.
void JitContext::replaceUint32AtOffset(size_t offset, uint32_t v) {
  replaceByteAtOffset(offset, v & 0xFF);
  replaceByteAtOffset(offset + 1, (v >> 8) & 0xFF);
  replaceByteAtOffset(offset + 2, (v >> 16) & 0xFF);
  replaceByteAtOffset(offset + 3, (v >> 24) & 0xFF);
}

// emit a 32-bit instruction in little endian encoding.
void JitContext::emitUint32(uint32_t v) {
  emitByte(v & 0xFF);
  emitByte((v >> 8) & 0xFF);
  emitByte((v >> 16) & 0xFF);
  emitByte((v >> 24) & 0xFF);
}

// emit a 64-bit instruction in little endian encoding.
void JitContext::emitUint64(uint64_t v) {
  emitUint32(v & 0xFFFFFFFF);
  emitUint32((v >> 32) & 0xFFFFFFFF);
}

// compute a 32-bit relative offset for jump instructions.
uint32_t computeRelativeOffset(size_t jumpFrom, size_t jumpTo) {
  if (jumpTo >= jumpFrom) {
    size_t diff = jumpTo - jumpFrom;
    assert(diff < (1ull << 31));
    return diff;
  } else {
    // Here the diff is negative, so we need to encode it as 2s complement.
    size_t diff = jumpFrom - jumpTo;
    assert(diff - 1 < (1ull << 31));
    uint32_t diff_unsigned = static_cast<uint32_t>(diff);
    return ~diff_unsigned + 1;
  }
}

// Machine tape state for the brain fuck program.
constexpr int MEMORY_SIZE = 30000;

void jitExec(const std::string& instructions, bool verbose) {
  // Initialize state.
  std::vector<uint8_t> memory(MEMORY_SIZE, 0);

  JitContext emitter;
  // stack used to keep track of brackets so we can adjust jump offsets.
  std::stack<size_t> bracketStack;

  // movabs addr, %r13
  emitter.emitBytes({0x49, 0xBD});
  emitter.emitUint64((uint64_t)memory.data());

  // core jit compiler loop.
  for (size_t pc = 0; pc < instructions.size(); ++pc) {
    // next instruction to jit.
    char instruction = instructions[pc];
    switch (instruction) {
    case '>':
      // increment the tape pointer
      // inc %r13
      emitter.emitBytes({0x49, 0xFF, 0xC5});
      break;
    case '<':
      // decrement the tape pointer
      // dec %r13
      emitter.emitBytes({0x49, 0xFF, 0xCD});
      break;
    case '+':
      // add 1 to the cell pointed at by the tape pointer
      // addb $1, 0(%r13)
      emitter.emitBytes({0x41, 0x80, 0x45, 0x00, 0x01});
      break;
    case '-':
      // substract 1 from the cell pointer at by the tape pointer
      // subb $1, 0(%r13)
      emitter.emitBytes({0x41, 0x80, 0x6D, 0x00, 0x01});
      break;
    case '.':
      // To print we need to make a syscall to `write()`.
      // According to the good folks who brought us the Linux
      // kernel and x86 ABI it goes something like this :
      // Syscall number for `write` is 1 and goes into `rax`
      // The first argument is `fd` for the file descriptor in this case
      // stdout (1) goes into `rsi`.
      // The second argument is `buf` the buffer we want to write and goes into
      // `rsi`.
      // Finally because it's C we need to provide a `size` which goes into
      // `rdx`.
      // In assembly it would look something like this.
      // mov $1, %rax
      // mov $1, %rdi
      // mov %r13, %rsi
      // mov $1, %rdx
      // syscall
      emitter.emitBytes({0x48, 0xC7, 0xC0, 0x01, 0x00, 0x00, 0x00});
      emitter.emitBytes({0x48, 0xC7, 0xC7, 0x01, 0x00, 0x00, 0x00});
      emitter.emitBytes({0x4C, 0x89, 0xEE});
      emitter.emitBytes({0x48, 0xC7, 0xC2, 0x01, 0x00, 0x00, 0x00});
      emitter.emitBytes({0x0F, 0x05});
      break;
    case ',':
      // To read from `stdin` we do the do the same incantantions
      // we used to write to `stdout`
      emitter.emitBytes({0x48, 0xC7, 0xC0, 0x00, 0x00, 0x00, 0x00});
      emitter.emitBytes({0x48, 0xC7, 0xC7, 0x00, 0x00, 0x00, 0x00});
      emitter.emitBytes({0x4C, 0x89, 0xEE});
      emitter.emitBytes({0x48, 0xC7, 0xC2, 0x01, 0x00, 0x00, 0x00});
      emitter.emitBytes({0x0F, 0x05});
      break;
    case '[':
      // Compare the value stored in the tape pointer to decide what's what
      // cmpb $0, 0(%r13)
      emitter.emitBytes({0x41, 0x80, 0x7d, 0x00, 0x00});

      // Save the offset location in the stack, and emit JZ
      // with placeholder zeroes that will be changed when we reach
      // the closing bracket.
      bracketStack.push(emitter.size());
      emitter.emitBytes({0x0F, 0x84});
      emitter.emitUint32(0);
      break;
    case ']': {
      // ensure the bracket is actualled closed
      if (bracketStack.empty()) {
        printf("unmatched closing ']' at pc=%d", pc);
      }
      // pop the bracket offset from the stack
      size_t openBracketOffset = bracketStack.top();
      bracketStack.pop();
      // do another compare
      // cmpb $0, 0(%r13)
      emitter.emitBytes({0x41, 0x80, 0x7d, 0x00, 0x00});

      // Compute the offset for this jump.
      size_t jumpBackFrom = emitter.size() + 6;
      size_t jumpBackTo = openBracketOffset + 6;
      uint32_t pcRelativeOffsetBack =
          computeRelativeOffset(jumpBackFrom, jumpBackTo);

      // jnz <open_bracket_location>
      emitter.emitBytes({0x0F, 0x85});
      emitter.emitUint32(pcRelativeOffsetBack);

      size_t jumpForwardFrom = openBracketOffset + 6;
      size_t jumpForwardTo = emitter.size();
      uint32_t pcRelOffsetForward =
          computeRelativeOffset(jumpForwardFrom, jumpForwardTo);
      emitter.replaceUint32AtOffset(openBracketOffset + 2,
                                    pcRelOffsetForward);
      break;
    }
    default: { printf("bad char %c @ pc = %d", instruction, pc); }
    }
  }

  // emit a ret instruction.
  emitter.emitByte(0xC3);

  // Load the emitted code to executable memory and run it.
  std::vector<uint8_t> jitCode = emitter.code();
  JitCache jitCache(jitCode);

  // JittedFunc is the C++ type for the JIT function emitted here. The emitted
  // function is callable from C++ and follows the x64 System V ABI.
  using JittedFunc = void (*)(void);

  JittedFunc func = (JittedFunc)jitCache.programMemory();
  func();

  if (verbose) {
    // Write the JITed program into a binary file in '/tmp'.
    const char* filename = "/tmp/simplejit.bin";
    FILE* outfile = fopen(filename, "wb");
    if (outfile) {
      size_t n = jitCode.size();
      if (fwrite(jitCode.data(), 1, n, outfile) == n) {
        std::cout << "* emitted code to " << filename << "\n";
      }
      fclose(outfile);
    }

    std::cout << "* Memory nonzero locations:\n";

    for (size_t i = 0, pcount = 0; i < memory.size(); ++i) {
      if (memory[i]) {
        std::cout << std::right << "[" << std::setw(3) << i
                  << "] = " << std::setw(3) << std::left
                  << static_cast<int32_t>(memory[i]) << "      ";
        pcount++;

        if (pcount > 0 && pcount % 4 == 0) {
          std::cout << "\n";
        }
      }
    }
    std::cout << "\n";
  }
}

int main(int argc, const char** argv) {
  bool verbose = true;
  std::string program = "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.";

  jitExec(program, verbose);


  return 0;
}
