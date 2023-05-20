as -g $1 -o $1.o
ld -v -macosx_version_min 13.0.0 $1.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _main -arch arm64
rm $1.o

