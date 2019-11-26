# Basics
#################
SHELL		?=	/bin/sh
RM		?=	-rm -rf
EMUL		?=	qemu-system-x86_64 -fda
ASM		=	nasm
LD		=	ld
CC		=	gcc
#################

# Paths
#################
PBOOT		=	./boot
PKERNEL		=	./kernel
PDRIVERS	=	./drivers

HEADER_DIR	=	include
HEADERS		=	$(PKERNEL)/$(HEADER_DIR)	\
			$(PDRIVERS)/$(HEADER_DIR)
#################

# Flags
#################
LDFLAGS		=	--oformat binary -Ttext 0x1000
CFLAGS		=	-ffreestanding -Wall -Wextra -Werror -O2
CPPFLAGS	=	-iquote $(HEADERS)
NAME		=	-o $@
#################

# Sources
#################
BOOT_SRC	=	$(PBOOT)/boot_sector.asm
KRN_ENTRY	=	$(PKERNEL)/krn_entry.asm
KRN_SRC		=	$(PKERNEL)/main.c	\
#################

# Obj Files
#################
BOOT_NAME	=	$(BOOT_SRC:.asm=.bin)
KRN_OBJ		=	$(KRN_SRC:.c=.o)
KRN_EOBJ	=	$(KRN_ENTRY:.asm=.o)
#################

# Important Files
#################
KRN_NAME	=	kernel.bin
OSIMG_NAME	=	fos
#################


# $< = first dependancy | $@ = target file | $^ = All dependancy
# Main Build Rules.
.PHONY:	run
run:	fclean $(OSIMG_NAME)
	@echo "Running [ $(OSIMG_NAME) ]"
	@$(EMUL) $(OSIMG_NAME)

.PHONY: disass
disass: $(KRN_NAME)
	ndisasm -b 32 $<
# [END] Main Build Rules.


# Important Build Rules.
$(OSIMG_NAME): $(BOOT_NAME) $(KRN_NAME)
	@echo "\nMaking [ $@ ]"
	@cat $^ > $@


$(KRN_NAME): $(KRN_OBJ) $(KRN_EOBJ)
	@echo "\nLinking $^ into [ $@ ]"
	@$(LD) $(NAME) $(LDFLAGS) $^
# [END] Important Build Rules.


# Obj Rules.
%.bin:	%.asm
	@echo "Compiling $< to [ $@ ]"
	@$(ASM) $^ -f bin $(NAME)

%.o:	%.c
	@echo "Compiling $< to [ $@ ]"
	@$(CC) $(CFLAGS) $(CPPFLAGS) -c $< $(NAME)

%.o:	%.asm
	@echo "Compiling $< to [ $@ ]"
	@$(ASM) $< -f elf64 $(NAME)
# [END] Obj Rules.


# Clean Rules.
.PHONY: clean
clean:
	@echo "Cleaning OBJ Files."
	$(RM) $(KRN_OBJ)
	$(RM) $(KRN_EOBJ)

.PHONY: fclean
fclean: clean
	@echo "\nCleaning main Files."
	$(RM) $(BOOT_NAME)
	$(RM) $(KRN_NAME)
	$(RM) $(OSIMG_NAME)
	@echo ""
# [END] Clean Rules.
