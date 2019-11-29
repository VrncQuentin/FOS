# Basics
#################
SHELL		?=	/bin/sh
RM		?=	-rm -rf
ASM		=	nasm
CC		=	gcc
#################

# Flags
#################
ASMFLAGS	=	-f elf64
CFLAGS		=	-ffreestanding -Wall -Wextra -Werror
CPPFLAGS	=	-iquote $(PHEADERS)
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
PBUILD		=	../build/objs/
PHEADERS	=	../include
PLIB		=	lib
PLLVL		=	llvl
#################

# Sources
#################
ENTRY		=	krn_entry.asm
SRC		=	main.c			\
			$(PLIB)/memcpy.c	\
			$(PLLVL)/io.c		\
#################

# Obj Files
#################
ENTRY_OBJ	=	$(ENTRY:.asm=.o)
SRC_OBJ		=	$(SRC:.c=.o)
#################

# Main Build Rules.
## Kernel Objs.
.PHONY:	all
all: disp_entry $(ENTRY_OBJ) $(SRC_OBJ)
	@mv $(ENTRY_OBJ) $(PBUILD)
	@mv $(SRC_OBJ) $(PBUILD)
	@echo "$(B)    |---$(CBM)[ Kernel's OBJ Files ] Moved to build/objs/.$(CN)"
	@echo "$(B)|---$(CBG)[ Kernel's OBJ Files ] OK.$(CN)"

## Debug.
.PHONY: debug
debug:	CFLAGS += -DDEBUG
debug:	all
# [END] Main Build Rules.


# Conversion Rules.
## ASM.
%.o:	%.asm
	@echo "$(B)    |---$(CBW)[ kernel/$< ] ==>>\t[ kernel/$@ ]$(CN)"
	@$(ASM) $(ASMFLAGS) $< -o $@

## C.
%.o:	%.c
	@echo "$(B)    |---$(CBW)[ kernel/$< ]\t ==>>\t[ kernel/$@ ]$(CN)"
	@$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@
# [END] Conversion Rules.


# Misc.
disp_entry:
	@echo "$(B)|---$(CBB)[ Kernel's OBJ Files ] Building.$(CN)"
# [END] Misc.
