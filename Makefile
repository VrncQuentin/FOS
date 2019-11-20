# Fundamentals.
#################
SHELL		?=	/bin/sh
RM		?=	rm -f
ASM		?=	nasm
EMUL		?=	qemu-system-x86_64
#################

# Paths.
#################
LP		=	./lib
SP		=	./src
#################


#Flags for compilation.
#################
ASMFLAGS	=	-f bin
#################


# Lib variables.
#################
#################


# Source Files.
#################
SS		=	$(SP)/boot_sector.asm	\
#################


# Conversions to .o.
#################
#################

# Binaries & lib names.
#################
BIN		=	boot_sector.bin
#################

$(BIN):
	$(ASM) $(ASMFLAGS) $(SS) -o $(BIN)

.PHONY: run
run:	$(BIN)
	$(EMUL) $(BIN)

.PHONY:	clean
clean:
	rm $(BIN)
