all:
	nasm -g -felf64 translateHexToASCII.asm -l translate.lst -o translate.o
	ld translate.o -o output

run: all
	./output
clean:
	rm translate.lst translate.o output
