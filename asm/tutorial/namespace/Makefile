build: clean
	mkdir -p target/ target/obj/ target/bin/
	nasm -f elf32 -o target/obj/namespace.o namespace.asm && ld -m elf_i386 -o target/bin/namespace target/obj/namespace.o

clean:
	rm -rf target
