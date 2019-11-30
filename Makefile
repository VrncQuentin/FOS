# Basics
#################
SHELL		?=	/bin/sh
RM		=	-rm -rf
EMUL		?=	qemu-system-x86_64 -k
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
PKERNEL		=	kernel
PDRIVERS	=	drivers
PSCREEN		=	$(PDRIVERS)/screen
#################

# Flags
#################
LDFLAGS		=	--oformat binary -Ttext 0x1000
ASMFLAGS	=	-f elf64
CFLAGS		=	-ffreestanding -Wall -Wextra -Werror -Wshadow
CPPFLAGS	=	-iquote $(PHEADERS)
#################

# Src
#################
KRN_ENTRY	=	$(PKERNEL)/kentry.asm
KRN_SRC		=	$(PKERNEL)/kmain.c
#################


# Obj Files
#################
KRNE_OBJ	=	$(KRN_ENTRY:.asm=.o)
KRN_OBJ		=	$(KRN_SRC:.c=.o)
#################

# Important Files
#################
FOS		=	$(PBUILD)/FOS.bin
#################


# $< = first dependancy | $@ = target file | $^ = All dependancy
# Main Rules.
.PHONY:	all
all:	fclean builddir $(FOS)
	@echo "$(CBY)[ FOS ] Running.$(CN)"
	$(EMUL) $(FOS)

.PHONY: disass
disass: $(FOS)
	ndisasm -b 32 $<

# .PHONY: debug
# [END] Main Rules.

# OS Bootstrap.
## Build Dir Preparation.
.PHONY:	builddir
builddir:
	@echo "\n$(CBB)[ Build Directory ] Preparing.$(CN)"
	-@mkdir $(PBUILD) &>/dev/null
	-@mkdir $(PBOBJ)  &>/dev/null
	@sleep 0.25
	@echo "$(CBG)[ Build Directory ] OK.$(CN)"

## FOS.
$(FOS):	$(KRNE_OBJ) $(KRN_OBJ)
	@echo "\n$(CBB)[ FOS ] Building .$(CN)"
	@echo "$(CBB)[ Kernel ] Linking Obj Files.$(CN)"
	@$(LD) -o $(FOS) $(LDFLAGS) $(PBOBJ)/*.o
	@echo "$(CBB)[ Kernel ] OK.$(CN)"
	@echo "$(CBG)[ FOS ] OK.$(CN)"
# [END] OS Bootstrap.

# Conversion Rules.
%.o:	%.asm
	$(ASM) $(ASMFLAGS) $^ -o $@
	@mv $@ $(PBOBJ)

%.o:	%.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $^ -o $@
	@mv $@ $(PBOBJ)
# [END] Conversion Rules.

# Clean Rules.
.PHONY: clean
clean:
	@echo "$(CBB)[ Cleaning OBJ Files ]$(CN)$(B)"
	$(RM) $(PBOBJ)

.PHONY: fclean
fclean: clean
	@echo "$(CBB)[ Cleaning Main Files ]$(CN)$(B)"
	$(RM) $(FOS)
	$(RM) $(PBUILD)
	@echo "$(CBG)[ Repository is all clean! Enjoy :) ]$(CN)"
# [END] Clean Rules.
