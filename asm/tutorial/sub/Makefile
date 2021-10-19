build: clean
	mkdir -p target/ target/obj/ target/bin/
	nasm -f elf32 -o target/obj/sub.o sub.asm && ld -m elf_i386 -o target/bin/sub target/obj/sub.o

clean:
	rm -rf target
