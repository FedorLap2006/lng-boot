OUTPUT_FORMAT(binary)

SECTIONS{
	output 0x7C00 : {
		build/loader.o
		build/kernel.o
		build/ports.o
		build/console.o
		. = ALIGN(4096);
	}
}
