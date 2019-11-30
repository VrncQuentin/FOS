# Basics
#################
SHELL		?=	/bin/sh
RM		=	-rm -rf
EMUL		?=	qemu-system-x86_64 -fda
ASM		=	nasm
CC		=	gcc
LD		=	ld
#################

# Colors
#################
CN		=	\e[0m
B		=	\e[1m
CBB		=	\e[1;34m
CBG		=	\e[1;92m
CBW		=	\e[1;97m
CBY		=	\e[1;93m
#################

# Paths
#################
PBUILD		=	build
PBOBJ		=	$(PBUILD)/objs
PHEADERS	=	include
PBOOT		=	boot
PKERNEL		=	kernel
PDRIVERS	=	drivers
PSCREEN		=	$(PDRIVERS)/screen
#################

# Flags
#################
LDFLAGS		=	--oformat binary -Ttext 0x1000
ASMFLAGS	=	-f
CFLAGS		=	-ffreestanding -Wall -Wextra -Werror -Wshadow
CPPFLAGS	=	-iquote $(PHEADERS)
#################

# Src
#################
BOOT_SRC	=	$(PBOOT)/boot_sector.asm
KRN_ENTRY	=	$(PKERNEL)/krn_entry.asm
KRN_SRC		=	$(PKERNEL)/main.c		\
#################


# Obj Files
#################
KRNE_OBJ	=	$(KRN_ENTRY:.asm=.o)
KRN_OBJ		=	$(KRN_SRC:.c=.o)
#################

# Important Files
#################
BOOT		=	$(BOOT_SRC:.asm=.bin)
KRN		=	$(PBUILD)/kernel.bin
FOS		=	fos
#################


# $< = first dependancy | $@ = target file | $^ = All dependancy
# Main Rules.
.PHONY:	all
all:	fclean builddir fos
	@echo "$(CBY)[ FOS ] Running.$(CN)"
	$(EMUL) $(FOS)

.PHONY: disass
disass: $(KRN)
	ndisasm -b 32 $<

# .PHONY: debug
# [END] Main Rules.

# OS Bootstrap.
## Build Dir Preparation.
.PHONY:	builddir
builddir:
	@echo "\n$(CBB)[ Build Directory ] Preparing.$(CN)"
	-@mkdir $(PBUILD) &>/dev/null
	-@mkdir $(PBUILD)/objs &>/dev/null
	@sleep 0.25
	@echo "$(CBG)[ Build Directory ] OK.$(CN)"

## FOS.
.PHONY:	fos
fos:	$(BOOT) kernel
	@echo "\n$(CBB)[ FOS ] Building.$(CN)"
	@cat $(PBUILD)/boot_sector.bin $(KRN) > $(FOS)
	@echo "$(CBG)[ FOS ] OK.$(CN)"

## Boot Sector Build.
%.bin:	%.asm
	$(ASM) $(ASMFLAGS) bin $^ -o $@
	mv $@ $(PBUILD)

%.o:	%.asm
	$(ASM) $(ASMFLAGS) elf64 $^ -o $@
	mv $@ $(PBOBJ)

%.o:	%.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $^ -o $@
	mv $@ $(PBOBJ)
## Kernel Build.
.PHONY:	kernel
kernel:	$(KRN_OBJ) $(KRNE_OBJ) $(DRIVERS_OBJ)
	@echo "$(CBB)[ Kernel ] Linking Obj Files.$(CN)"
	@$(LD) -o $(KRN) $(LDFLAGS) $(PBOBJ)/*.o
	@echo "$(CBB)[ Kernel ] OK.$(CN)"
# [END] OS Bootstrap.

# Clean Rules.
.PHONY: clean
clean:
	@echo "$(CBB)[ Cleaning OBJ Files ]$(CN)$(B)"
	$(RM) $(PBOBJ)

.PHONY: fclean
fclean: clean
	@echo "$(CBB)[ Cleaning Main Files ]$(CN)$(B)"
	$(RM) $(BOOT)
	$(RM) $(KRN)
	$(RM) $(FOS)
	$(RM) $(PBUILD)
	@echo "$(CBG)[ Repository is all clean! Enjoy :) ]$(CN)"
# [END] Clean Rules.
