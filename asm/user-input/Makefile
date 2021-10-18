build: clean
	mkdir -p target/ target/obj/ target/bin/
	nasm -f elf32 -o target/obj/user_input.o user_input.asm && ld -m elf_i386 -o target/bin/user_input target/obj/user_input.o

clean:
	rm -rf target
