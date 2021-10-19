build: clean
	mkdir -p target/ target/obj/ target/bin/
	nasm -f elf32 -o target/obj/div.o div.asm && ld -m elf_i386 -o target/bin/div target/obj/div.o

clean:
	rm -rf target
