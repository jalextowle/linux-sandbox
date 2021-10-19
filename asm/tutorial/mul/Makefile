build: clean
	mkdir -p target/ target/obj/ target/bin/
	nasm -f elf32 -o target/obj/mul.o mul.asm && ld -m elf_i386 -o target/bin/mul target/obj/mul.o

clean:
	rm -rf target
