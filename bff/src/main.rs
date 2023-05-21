pub fn interpret(source: &str) {
    assert!(source.len() > 0);
    let code: Vec<_> = source.chars().collect();
    let mut curr = code[0];
    let mut tape: [u8; 30000] = [0; 30000];
    let mut ptr = 0 as usize;

    for i in 0..source.len() {
        match code[i] {
            '>' => ptr += 1,
            '<' => ptr -= 1,
            '+' => tape[ptr] += 1,
            '-' => tape[ptr] -= 1,
            '.' => println!("{:?}", tape[ptr]),
            _ => (),
        }
    }
    println!("{:?}", ptr);
}

fn main() {
    let test_program = ">>>>++.";
    println!("Welcom to BFF (Brainf*ck Friends) interpreter and compiler.");
    interpret(test_program);
}
