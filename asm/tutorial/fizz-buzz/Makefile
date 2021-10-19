build: clean
	mkdir -p target/ target/obj/ target/bin/
	nasm -f elf32 -o target/obj/fizz_buzz.o fizz_buzz.asm && ld -m elf_i386 -o target/bin/fizz_buzz target/obj/fizz_buzz.o

clean:
	rm -rf target
