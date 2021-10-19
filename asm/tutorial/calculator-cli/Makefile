build: clean
	mkdir -p target/ target/obj/ target/bin/
	nasm -f elf32 -o target/obj/calculator.o calculator.asm && ld -m elf_i386 -o target/bin/calculator target/obj/calculator.o

clean:
	rm -rf target
