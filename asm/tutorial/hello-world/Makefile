build: 
	mkdir target target/obj/ target/bin
	nasm -f elf32 -o target/obj/hello32.o hello32.asm && ld -m elf_i386 -o target/bin/hello32 target/obj/hello32.o
	nasm -f elf32 -o target/obj/string_count_32.o string_count_32.asm && ld -m elf_i386 -o target/bin/string_count_32 target/obj/string_count_32.o
	nasm -f elf32 -o target/obj/string_count_function_32.o string_count_function_32.asm && ld -m elf_i386 -o target/bin/string_count_function_32 target/obj/string_count_function_32.o
	nasm -f elf64 -o target/obj/hello64.o hello64.asm && ld target/obj/hello64.o -o target/bin/hello64

clean:
	rm -r target *.o 
