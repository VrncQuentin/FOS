# Basics
#################
SHELL		?=	/bin/sh
RM		?=	-rm -rf
EMUL		?=	qemu-system-x86_64
ASM		=	nasm
LD		=	ld
CC		=	gcc
#################

# Paths
#################
PKERNEL		=	./kernel
PBOOTSECTOR	=	./bs
INCLUDE_DIR	=	include
#################

# Flags
#################
LDFLAGS		=	--oformat binary -Ttext 0x1000
CFLAGS		=	-ffreestanding
CPPFLAGS	=	-iquote $(PKERNEL)/$(INCLUDE_DIR)
#################

# Sources
#################
KRN_MAINS	=	$(PKERNEL)/main.c
KRN_ENTRYS	=	$(PKERNEL)/kernel_entry.asm
BS_MAINS	=	$(PBOOTSECTOR)/boot_sector.asm
#################

# Obj Files
#################
KRN_MAIN	=	$(PKERNEL)/main.o
KRN_ENTRY	=	$(PKERNEL)/kernel_entry.o
KRN_OBJ		=	$(KRN_MAIN)	\
			$(KRN_ENTRY)	\
#################

# Important Files
#################
BS_NAME		=	boot_sector.bin
KRN_NAME	=	kernel.bin
OSIMG_NAME	=	fos
#################


# Main Build Rules.
.PHONY:	run
run:	fclean $(OSIMG_NAME)
	$(EMUL) $(OSIMG_NAME)

$(OSIMG_NAME): $(BS_NAME) $(KRN_NAME)
	cat $(BS_NAME) $(KRN_NAME) > $(OSIMG_NAME)

$(KRN_NAME): $(KRN_OBJ)
	$(LD) -o $(KRN_NAME) $(LDFLAGS) $(KRN_OBJ)
# [END] Main Build Rules.


# Obj Rules.
$(BS_NAME): $(BS_MAINS)
	$(ASM) $(BS_MAINS) -f bin -o $(BS_NAME)

$(KRN_MAIN): $(KRN_MAINS)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $(KRN_MAINS) -s -o $(KRN_MAIN)

$(KRN_ENTRY): $(KRN_ENTRYS)
	$(ASM) $(KRN_ENTRYS) -f elf64 -o $(KRN_ENTRY)
# [END] Obj Rules.


# Clean Rules.
.PHONY: clean
clean:
	@echo "Cleaning OBJ Files."
	$(RM) $(KRN_OBJ)

.PHONY: fclean
fclean: clean
	@echo "\nCleaning main Files."
	$(RM) $(KRN_NAME)
	$(RM) $(BS_NAME)
	$(RM) $(OSIMG_NAME)
	@echo ""
# [END] Clean Rules.
