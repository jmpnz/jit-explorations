clang -c $1
objdump -d ${1%.*}.o > ${1%.*}.codegen
