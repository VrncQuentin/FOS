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
CBB		=	\e[1;34m
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
all: $(ENTRY_OBJ) $(SRC_OBJ)
	@mv $(ENTRY_OBJ) $(PBUILD)
	@mv $(SRC_OBJ) $(PBUILD)
	@echo "$(CBB)[ Kernel's OBJ Files ] Moved to build/objs/.$(CN)"


## Debug.
.PHONY: debug
debug:	CFLAGS += -DDEBUG
debug:	all
# [END] Main Build Rules.


# Conversion Rules.
## ASM.
%.o:	%.asm
	@echo "$(CBW)[ kernel/$< ] ==>>\t[ kernel/$@ ]$(CN)"
	@$(ASM) $(ASMFLAGS) $< -o $@

## C.
%.o:	%.c
	@echo "$(CBW)[ kernel/$< ]\t ==>>\t[ kernel/$@ ]$(CN)"
	@$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@
# [END] Conversion Rules.
