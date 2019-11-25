# Fundamentals.
#################
SHELL		?=	/bin/sh
RM		?=	-rm -f
ASM		?=	nasm
EMUL		?=	qemu-system-x86_64
CC		=	gcc
LD		?=	ld
#################

# Paths.
#################
LIBC_P		=	./lib/c
BS_P		=	./bs
KERNEL_P	=	./kernel
INCLUDE_DIR	=	include
#################


#Flags for compilation.
#################
ASMFLAGS	=	-f bin
CPPFLAGS	=	-iquote $(KERNEL_P)/$(INCLUDE_DIR)
CFLAGS		=	-ffreestanding
LDFLAGS		=	-Ttext 0x1000
#################


# Lib variables.
#################
#################


# Source Files.
#################
BS_SRC		=	$(BS_P)/boot_sector.asm		\

KERNEL_SRC	=	$(KERNEL_P)/main.c		\
#################


# Conversions to .o.
#################
KERNEL_OBJ	=	$(KERNEL_SRC:.c=.o)
#################

# Binaries & lib names.
#################
BS_NAME		=	boot_sector.bin
KERNEL_NAME	=	kernel.bin
OSIMG		=	fos
#################


.PHONY: run
run:	fclean $(OSIMG)
	$(EMUL) $(OSIMG)

$(BS_NAME):
	$(ASM) $(ASMFLAGS) $(BS_SRC) -o $(BS_NAME)


$(KERNEL_NAME):	$(KERNEL_OBJ)
	$(LD) $(LDFLAGS) $(KERNEL_OBJ) --oformat binary -o $(KERNEL_NAME)


$(OSIMG): $(BS_NAME) $(KERNEL_NAME)
	cat $(BS_NAME) $(KERNEL_NAME) > $(OSIMG)

.PHONY:	clean
clean:
	$(RM) $(KERNEL_OBJ)

.PHONY: fclean
fclean: clean
	$(RM) $(BS_NAME)
	$(RM) $(KERNEL_NAME)
	$(RM) $(OSIMG)
