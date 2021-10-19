build: clean
	mkdir -p target/ target/obj/ target/bin/
	nasm -f elf32 -o target/obj/add.o add.asm && ld -m elf_i386 -o target/bin/add target/obj/add.o

clean:
	rm -rf target
