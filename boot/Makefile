# Basics
#################
SHELL		?=	/bin/sh
RM		?=	-rm -rf
ASM		=	nasm
ASMFLAGS	=	-f bin
#################

# Colors
#################
CN		=	\e[0m
CBB		=	\e[1;35m
CBW		=	\e[1;97m
#################

# Path
#################
PBUILD		=	../build
#################

# Source
#################
BS_SRC		=	boot_sector.asm
#################

# End file
#################
BS_NAME		=	$(BS_SRC:.asm=.bin)
#################

# Boot Sector Compilation.
.PHONY: all
all: $(BS_NAME)
	@mv $(BS_NAME) $(PBUILD)/$(BS_NAME)
	@echo "$(CBB)[ Boot Sector ] Moved to build/.$(CN)"

## Conversion.
%.bin: %.asm
	@echo "$(CBW)[ boot/$< ] ==>> [ boot/$@ ]$(CN)"
	@$(ASM) $(ASMFLAGS) $^ -o $@
# [END] Boot Sector Compilation.
