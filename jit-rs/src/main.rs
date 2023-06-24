// use dynasmrt::{dynasm, AssemblyOffset, DynasmApi, ExecutableBuffer};
use dynasmrt::dynasm;
use dynasmrt::{DynasmApi, DynasmLabelApi, ExecutableBuffer};

fn main() {
    // Create a buffer to hold the generated machine code
    let mut buffer = ExecutableBuffer::new(4096).unwrap();

    // Build the function using Dynasm
    let code_offset = build_function(&mut buffer);

    // Execute the generated machine code
    let add_fn: extern "C" fn(u64, u64) -> u64 =
        unsafe { std::mem::transmute(buffer.ptr(code_offset)) };

    // Call the generated function and print the result
    let result = add_fn(42, 13);
    println!("Result: {}", result);
}

fn build_function(buffer: &mut ExecutableBuffer) -> dynasmrt::AssemblyOffset {
    let mut builder = dynasmrt::x64::Assembler::new();
    let begin = builder.as_ref().expect("REASON").offset();

    dynasm!(builder.as_mut().expect("REASON")
        ; movz x0, 42
        ; movz x1, 13//, lsl 16
        ; add x0, x0, x1
        ; ret
    );
    let offset = builder.as_ref().expect("REASON").offset();
    *buffer = builder.expect("REASON").finalize().unwrap();
    dynasmrt::AssemblyOffset(0)
}
