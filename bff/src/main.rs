use std::io::stdin;

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
            '.' => println!("{}", tape[ptr]),
            ',' => {
                let mut s = String::new();
                stdin().read_line(&mut s).expect("What you wrote isn't text -__-");
                tape[ptr] = s.chars().nth(0).unwrap() as u8;
            }, // This should read input.
            '[' => {
                if tape[ptr] == 0 {
                   let mut bracket_nesting = 1;
                   let saved_pc = pc;
                    while bracket_nesting != 0 && pc + 1 < code.len() {
                        if code[pc] == ']' {
                            bracket_nesting -= 1;
                        } else if code[pc] == '[' {
                            bracket_nesting += 1;
                        }
                        pc += 1;
                    }
                    if bracket_nesting == 0 {
                        break;
                    } else {
                        panic!("unmatched '[' at pc = {}", saved_pc);
                    }
                }

            },
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
                    if bracket_nesting == 0 {
                        break;
                    } else {
                        panic!("unmatched ']' at pc = {}", saved_pc);
                    }
                }
            }
            _ => (),
        }
        pc += 1;
    }
}

fn main() {
    let _test_program = ">>>>++.";
    let echo_program = "+[>,.,.<]";
    println!("Welcom to BFF (Brainf*ck Friends) interpreter and compiler.");
    interpret(echo_program);
}
