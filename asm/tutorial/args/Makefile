build: clean
	mkdir -p target/ target/obj/ target/bin/
	nasm -f elf32 -o target/obj/args.o args.asm && ld -m elf_i386 -o target/bin/args target/obj/args.o

clean:
	rm -rf target
