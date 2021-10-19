build: clean
	mkdir -p target/ target/obj/ target/bin/
	nasm -f elf32 -o target/obj/convert_to_string.o convert_to_string.asm && ld -m elf_i386 -o target/bin/convert_to_string target/obj/convert_to_string.o
	nasm -f elf32 -o target/obj/count_by_number.o count_by_number.asm && ld -m elf_i386 -o target/bin/count_by_number target/obj/count_by_number.o

clean:
	rm -rf target
