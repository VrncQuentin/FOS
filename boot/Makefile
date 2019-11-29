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
B		=	\e[1m
CBB		=	\e[1;34m
CBM		=	\e[1;35m
CBG		=	\e[1;92m
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
all: disp_entry $(BS_NAME)
	@mv $(BS_NAME) $(PBUILD)/$(BS_NAME)
	@echo "$(B)|---$(CBM)[ Boot Sector ] Moved to build/.$(CN)"
	@echo "$(CBG)[ Boot Sector ] OK.$(CN)"

## Conversion.
%.bin: %.asm
	@echo "$(B)|---$(CBW)[ boot/$< ] ==>> [ boot/$@ ]$(CN)"
	@$(ASM) $(ASMFLAGS) $^ -o $@
# [END] Boot Sector Compilation.

# Misc.
disp_entry:
	@echo "\n$(CBB)[ Boot Sector ] Building.$(CN)"

.PHONY: all disp_entry
# [END] Misc.
