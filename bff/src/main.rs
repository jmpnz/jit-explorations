use std::env;
use std::fs::File;
use std::io::prelude::*;
use std::io::stdin;
use std::io::*;

const USAGE_CMD: &'static str = "Welcom to BFF (Brainf*ck Friends) interpreter and compiler.\n
Usage: bff [file] -- Runs a Brainf*ck program from a file.
Usage: bff jumptable [file] -- Runs a Brainf*ck program using a jumptable.
Usage: bff examples -- Runs an example program to print 'Hello World!'.
";

fn read_file(file_path: &str) -> String {
    let mut f = File::open(file_path).expect("File not found");
    let mut buffer = String::new();
    f.read_to_string(&mut buffer).unwrap();

    buffer
}

fn compute_jumptable(source: &str) -> Vec<usize> {
    // Program code and size.
    let code: Vec<_> = source.chars().collect();
    let sz = code.len();
    // Jump table.
    let mut jump_table = vec![0 as usize; sz];
    // Program counter.
    let mut pc = 0 as usize;

    while pc < sz {
        let inst = code[pc];
        if inst == '[' {
            let mut bracket_nesting = 1;
            let mut seek = pc;
            while bracket_nesting != 0 && {
                seek = seek + 1;
                seek < sz
            } {
                if code[seek] == ']' {
                    bracket_nesting -= 1;
                } else if code[seek] == '[' {
                    bracket_nesting += 1;
                }
            }
            if bracket_nesting == 0 {
                jump_table[pc] = seek;
                jump_table[seek] = pc;
            } else {
                panic!("Unmatched '[' at pc : {}", pc);
            }
        }
        pc += 1;
    }
    jump_table
}

pub fn interpret_with_jumptable(source: &str) {
    assert!(source.len() > 0);
    // Collect chars into a vec so we can do some indexing.
    let code: Vec<_> = source.chars().collect();
    // Tape where we do thingfs.
    let mut tape = [0 as u8; 30000];
    // Pointer into the tape.
    let mut ptr = 0 as usize;
    // Program counter.
    let mut pc = 0 as usize;
    // Build jump table.
    let mut jump_table = compute_jumptable(source);

    // Current character we're processing.
    let mut curr = code[0];
    while pc < code.len() {
        curr = code[pc];
        match curr {
            '>' => ptr += 1,
            '<' => ptr -= 1,
            '+' => tape[ptr] += 1,
            '-' => tape[ptr] -= 1,
            '.' => print!("{}", tape[ptr] as char),
            ',' => {
                let mut s = String::new();
                stdin()
                    .read_line(&mut s)
                    .expect("What you wrote isn't text -__-");
                tape[ptr] = s.chars().nth(0).unwrap() as u8
            } // This should read input.
            '[' => {
                if tape[ptr] == 0 {
                    pc = jump_table[pc];
                }
            }
            ']' => {
                if tape[ptr] != 0 {
                    pc = jump_table[pc];
                }
            }
            _ => (),
        }
        pc += 1;
    }
}

pub fn interpret(source: &str) {
    assert!(source.len() > 0);
    // Collect chars into a vec so we can do some indexing.
    let code: Vec<_> = source.chars().collect();
    // Tape where we do thingfs.
    let mut tape: [u8; 30000] = [0; 30000];
    // Pointer into the tape.
    let mut ptr = 0 as usize;
    // Program counter.
    let mut pc = 0 as usize;

    // Current character we're processing.
    let mut curr = code[0];
    while pc < code.len() {
        curr = code[pc];
        match curr {
            '>' => ptr += 1,
            '<' => ptr -= 1,
            '+' => tape[ptr] += 1,
            '-' => tape[ptr] -= 1,
            '.' => print!("{}", tape[ptr] as char),
            ',' => {
                let mut s = String::new();
                stdin()
                    .read_line(&mut s)
                    .expect("What you wrote isn't text -__-");
                tape[ptr] = s.chars().nth(0).unwrap() as u8
            } // This should read input.
            '[' => {
                if tape[ptr] == 0 {
                    let mut bracket_nesting = 1;
                    let saved_pc = pc;
                    while bracket_nesting != 0 {
                        if code[pc] == ']' {
                            bracket_nesting -= 1;
                        } else if code[pc] == '[' {
                            bracket_nesting += 1;
                        }
                    }
                }
            }
            ']' => {
                if tape[ptr] != 0 {
                    let mut bracket_nesting = 1;
                    let saved_pc = pc;

                    while bracket_nesting != 0 && pc > 0 {
                        pc -= 1;
                        if code[pc] == '[' {
                            bracket_nesting -= 1;
                        } else if code[pc] == ']' {
                            bracket_nesting += 1;
                        }
                    }
                }
            }
            _ => (),
        }
        pc += 1;
    }
}

fn main() {
    if env::args().len() < 2 {
        println!("{}", USAGE_CMD);
        return;
    }
    if env::args().nth(1).unwrap() == "examples" {
        let _test_program = ">>>>++.";
        let _echo_program = "+[>,.,.<]";
        let hello_world = "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.";
        println!("Welcom to BFF (Brainf*ck Friends) interpreter and compiler.");
        interpret(hello_world);
    } else {
        let file_name = env::args().nth(1).unwrap();
        let program = read_file(&file_name);
        interpret(&program);
        // interpret_with_jumptable(&program);
    }
}
