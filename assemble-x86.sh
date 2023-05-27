if [ $# -eq 0 ];
then
    echo "Assemble and run x86-64 binaries on Apple Silicon"
    echo "Usage : sh assemble-x86.sh file.S"
fi
if ! [ -x "$(command -v blink)" ];
then
    echo "Blink could not be found on your machine"
    echo "To install Blink see : https://github.com/jart/blink"
fi

if ! [ -x "$(command -v x86_64-linux-musl-cc)" ];
then
    echo "You need a x86_64 toolchain on your machine."
    echo "To install x86-64 ELF gcc you can use brew :"
    echo "brew install x86_64-elf-gcc"
    echo "You can also use x86_64-linux-musl-cc if you need libc for your code"
fi

x86_64-linux-musl-cc -static $1 -o $1.out
blink $1.out
