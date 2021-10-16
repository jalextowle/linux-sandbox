build: clean
	mkdir -p target/ target/obj/ target/bin/
	nasm -f elf32 -o target/obj/string_count.o string_count.asm && ld -m elf_i386 -o target/bin/string_count target/obj/string_count.o
	nasm -f elf32 -o target/obj/string_count_function.o string_count_function.asm && ld -m elf_i386 -o target/bin/string_count_function target/obj/string_count_function.o
	nasm -f elf32 -o target/obj/string_count_include.o string_count_include.asm && ld -m elf_i386 -o target/bin/string_count_include target/obj/string_count_include.o
	nasm -f elf32 -o target/obj/string_count_include_fixed.o string_count_include_fixed.asm && ld -m elf_i386 -o target/bin/string_count_include_fixed target/obj/string_count_include_fixed.o
	nasm -f elf32 -o target/obj/string_count_line_feed.o string_count_line_feed.asm && ld -m elf_i386 -o target/bin/string_count_line_feed target/obj/string_count_line_feed.o

clean:
	rm -r target
