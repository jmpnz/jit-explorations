// Memory for LC-3 VM, has max size 65536 cells.
const MEMORY_MAX: usize = 1 << 16;

// Register definitions.
#[derive(Copy, Clone, Debug)]
enum Register {
    R0,
    R1,
    R2,
    R3,
    R4,
    R5,
    R6,
    R7,
    Pc,
    Cond,
    Count,
}

// Opcodes
#[derive(Copy, Clone, Debug)]
enum OPCode {
    Br,
    Add,
    Ld,
    St,
    Jsr,
    And,
    Ldr,
    Str,
    Rti,
    Not,
    Ldi,
    Sti,
    Jmp,
    Res,
    Lea,
    Trap,
}

impl OPCode {
    // We can't cast enums to integers (for good reason) this function
    // allows us to "cast" u16 values in memory as opcodes if they're
    // a match.
    pub fn get(op: u16) -> Option<OPCode> {
        match op {
            0 => Some(OPCode::Br),
            1 => Some(OPCode::Add),
            2 => Some(OPCode::Ld),
            3 => Some(OPCode::St),
            4 => Some(OPCode::Jsr),
            5 => Some(OPCode::And),
            6 => Some(OPCode::Ldr),
            7 => Some(OPCode::Str),
            8 => Some(OPCode::Rti),
            9 => Some(OPCode::Not),
            10 => Some(OPCode::Ldi),
            11 => Some(OPCode::Sti),
            12 => Some(OPCode::Jmp),
            13 => Some(OPCode::Res),
            14 => Some(OPCode::Lea),
            15 => Some(OPCode::Trap),
            _ => None,
        }
    }
}

// Condition flags.
#[derive(Copy, Clone, Debug)]
enum CondFlags {
    Pos = 1 << 0,
    Zero = 1 << 1,
    Neg = 1 << 2,
}

// Virtual machine
#[derive(Debug)]
pub struct VirtualMachine {
    pub registers: [u16; Register::Count as usize],
    pub memory: [u16; MEMORY_MAX],
}

impl VirtualMachine {
    // Create a new VM instance.
    pub fn new() -> Self {
        Self {
            registers: [0 as u16; Register::Count as usize],
            memory: [0 as u16; MEMORY_MAX],
        }
    }
    // Read from memory at given index.
    pub fn read(&self, pos: usize) -> u16 {
        self.memory[pos]
    }
    // Update condition flags on each register write.
    pub fn update_flags(&mut self, r: u16) {
        if self.registers[r as usize] == 0 {
            self.registers[Register::Cond as usize] = CondFlags::Zero as u16;
        } else if (self.registers[r as usize] >> 15) != 0 {
            self.registers[Register::Cond as usize] = CondFlags::Neg as u16;
        } else {
            self.registers[Register::Cond as usize] = CondFlags::Pos as u16;
        }
    }

    // Execute add instruction.
    pub fn add(&mut self, inst: u16) {
        // destination register.
        let r0 = (inst >> 9) & 0x7;
        // source operand.
        let r1 = (inst >> 6) & 0x7;
        // execution mode (immediate or register)
        let mode = (inst >> 5) & 0x1;

        if mode != 0 {
            // five-bit immediate
            let imm5 = sext(inst & 0x1f, 5);
            self.registers[r0 as usize] = self.registers[r1 as usize] + imm5;
        } else {
            let r2 = inst & 0x7;
            self.registers[r0 as usize] =
                self.registers[r1 as usize] + self.registers[r2 as usize];
        }
        self.update_flags(r0)
    }
}

// Sign extension for immediate values, sign extension is used
// to extend values stored in n-bits to m-bits (m > n) and also
// preserve their sign.
fn sext(x: u16, bit_count: usize) -> u16 {
    if ((x >> (bit_count - 1)) & 1) != 0 {
        x | (0xFFFF << bit_count)
    } else {
        x
    }
}

fn main() {
    // Program counter starts at 0x3000.
    let PcStart = 0x3000 as u16;
    // Start by setting the Z flag.
    let mut vm = VirtualMachine::new();
    vm.registers[Register::Cond as usize] = CondFlags::Zero as u16;
    vm.registers[Register::Pc as usize] = 0x3000;
    vm.memory[0x3000] = OPCode::Add as u16;
    loop {
        // Offset of the next instruction.
        let offset = vm.registers[Register::Pc as usize];
        // Fetch the next instruction.
        let inst = vm.read(offset as usize);
        // Decode the next instruction.
        let op = inst >> 12;

        match OPCode::get(inst) {
            Some(OPCode::Add) => println!("Add"),
            Some(OPCode::And) => println!("And"),
            Some(OPCode::Not) => println!("Not"),
            Some(OPCode::Br) => println!("Br"),
            Some(OPCode::Jmp) => println!("Jmp"),
            Some(OPCode::Jsr) => println!("Jsr"),
            Some(OPCode::Ld) => println!("Ld"),
            Some(OPCode::Ldi) => println!("Ldi"),
            Some(OPCode::Ldr) => println!("Ldr"),
            Some(OPCode::Lea) => println!("Lea"),
            Some(OPCode::St) => println!("St"),
            Some(OPCode::Sti) => println!("Sti"),
            Some(OPCode::Str) => println!("Str"),
            Some(OPCode::Trap) => println!("Trap"),
            Some(OPCode::Res | OPCode::Rti) => println!("Riti"),
            None => println!("Unknown instruction"),
        }
        break;
    }

    println!("Hello, world!");
}
