// Memory for LC-3 VM, has max size 65536 cells.
const MEMORY_MAX: usize = 1 << 16;
// static mut MEMORY: &'static mut [u16] = &mut [0; MEMORY_MAX];

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

// Registers.
static mut REGISTERS: &'static mut [u16] = &mut [0; Register::Count as usize];

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
        let offset = vm.registers[Register::Pc as usize];
        println!("Offset : {:#0x}", offset);
        let inst = vm.read(offset as usize);

        match OPCode::get(inst) {
            Some(OPCode::Add) => println!("OPAdd"),
            None => println!("Unknown instruction"),
            _ => println!("Misaligned instruction or code"),
        }
        break;
    }

    println!("Hello, world!");
}
