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

if ! [ -x "$(command -v x86_64-elf-gcc)" ];
then
    echo "x86-64 ELF gcc toolchain could not be found on your machine"
    echo "To install x86-64 ELF gcc you can use brew :"
    echo "brew install x86_64-elf-gcc"
fi

x86_64-elf-gcc -nostdlib $1 -o $1.out
blink $1.out
