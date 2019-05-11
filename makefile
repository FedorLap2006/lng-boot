ifeq ($(OS),Windows_NT)
	BUILDOS ?= win
	LDEMU=-mi386pe
else
	BUILDOS ?= nix
	LDEMU=-melf_i386
endif

ARCH?=x86
DEBUG?=on
OSNAME?=DepthOS
OSVER?=1.0
CSTD=11
CEMU=-m32
CCFLAGS= -Iinclude -ffreestanding -nostdlib -nostdinc -fno-builtin -fno-exceptions -fno-leading-underscore -fno-pic
CCFLAGS += -W -Wall -Wno-unused-parameter -Wno-type-limits
BUILD_FOLDER=build
OUTBIN=$(BUILD_FOLDER)/$(OSNAME)-$(OSVER).bin

LDFILE=link.ld
NASM_LOADER=loader.asm
C_SOURCES=kernel.c io/console.c io/ports.c


#========================================================================================
#========================================================================================
#========================================================================================

#all: compile debug
all: compile testing

compile:
	@echo ---------- build $(OSNAME) ----------
	@echo -------- os version is $(OSVER) --------
	@echo ---------- build for $(BUILDOS) ----------
	@echo -----------------------------------
	@echo ------------ clearing -------------
	rm -f $(BUILD_FOLDER)/*.o
	rm -f $(BUILD_FOLDER)/*.bin
	@echo -----------------------------------
	@echo ------------ compilling -----------
	nasm $(NASM_LOADER) -o $(BUILD_FOLDER)/loader.o -f elf32
	gcc $(CEMU) -std=c$(CSTD) -c $(C_SOURCES) $(CCFLAGS)
	mv *.o $(BUILD_FOLDER)/
	@echo -----------------------------------
	@echo ------------- linking -------------
	ld $(LDEMU) -T$(LDFILE) -o $(OUTBIN)
#	@echo ---------- HEX INFO ----------
#	@echo $(OUTBIN) hex info
#	hexdump -x $(OUTBIN)

testing:
	@echo -----------------------------------
	@echo ----------- testing os ------------
	qemu-system-i386 -machine pc-i440fx-2.8 -drive file="$(OUTBIN)",format=raw

debug:
	@echo -----------------------------------
	@echo ---------- debuging os ------------
	qemu-system-i386 -s -S -machine pc-i440fx-2.8 -drive file="$(OUTBIN)",format=raw &
	gdb
#target remote localhost:1234	подключиться к отладчику
#break *0x7C00			установить точку останова
#c				начать выполнение кода
#x/10i $cs*16+$eip		показать 10 следующих инструкций
#delete N			удалить точку останова N
#stepi				сделать шаг
#quit				завершить работу отладчика
