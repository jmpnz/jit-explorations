filename=$(echo $1 | cut -f 1 -d '.')
nasm -f elf64 -o $filename.o $1;x86_64-elf-ld -o $filename $filename.o
