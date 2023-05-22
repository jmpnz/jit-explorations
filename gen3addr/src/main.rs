/// The following code shows how to generate 3-address code instructions
/// from a very simple parse tree.
///
/// Unlike most resources you'll find online we don't do a source to source
/// transformation but instead emit 3 code assembly.
/// There are a few to opt in for doing this instead of the source to source
/// transformation.
/// 1. Using an IR makes it easy to compile to assembly.
/// 2. Assuming we have infinite registers makes codegen very simple
/// 3. Compiler can always do register allocation during the final step
///
/// This is mostly to demonstrate the concept you can learn more here :
/// https://www.uio.no/studier/emner/matnat/ifi/INF5110/v16/slides/10-ircodegen.pdf

/// Op kinds.
#[derive(Debug)]
enum OpKind {
    Plus,
    Minus,
    Star,
    Slash,
}

/// Expression struct.
#[derive(Debug)]
enum Expr {
    BinOp(OpKind, Box<Expr>, Box<Expr>),
    Literal(i64),
    Var(String),
    Unary(Box<Expr>),
}

/// We use a very basic 3 address code that can be represented as follow:
/// We have 8 registers r1, r2, r3, r4, r5, r6, r7, r8.
/// Arithmetic Operations :
/// (ADD | SUB | MUL | DIV) r1, r2, r3
/// Memory Access :
/// LDI r1, r2 <=> r1 = r2
/// STI r1, r2 <=> r1 = r2
///
/// The following routines will emit an operation based on the expression kind.

/// Emitting a literal is equivalent to store a value literal into a register.
fn emit_literal(reg: i32, lit: i64) {
    println!("STI r{}, {}", reg, lit);
}

/// Emitting a variable expression is equivalent to loading a value.
fn emit_var(dst: i32, src: i32) {
    println!("LDI r{}, r{}", src, dst);
}

/// Emitting an arithmetic operation on a binary expression.
fn emit_op(op: OpKind, dst: i32, r1: i32, r2: i32) {
    let opStr = match op {
        OpKind::Plus => "ADD",
        OpKind::Minus => "SUB",
        OpKind::Star => "MUL",
        OpKind::Slash => "DIV",
    };
    println!("{} r{}, r{}, r{}", opStr, dst, r1, r2);
}

/// Emitting 3-addr code on an expression.
fn emit(expr: Expr) {
    match expr {
        Expr::Literal(cst) => emit_literal(1, cst),
        Expr::BinOp(op, left, right) => {
            emit(*left);
            emit(*right);
            emit_op(op, 5, 3, 4);
        }
        _ => println!(""),
    }
}

fn main() {
    let expr = Expr::BinOp(
        OpKind::Star,
        Box::new(Expr::Literal(31)),
        Box::new(Expr::Literal(42)),
    );
    emit(expr);
    emit_op(OpKind::Plus, 3, 1, 2);
    println!("Hello, world!");
}
