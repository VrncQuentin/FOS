# Basics
#################
SHELL		?=	/bin/sh
RM		=	-rm -rf
EMUL		?=	qemu-system-x86_64 -fda
LD		=	ld
MAKE		=	@make --silent
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
PBOOT		=	boot
PKERNEL		=	kernel
PDRIVERS	=	drivers
#################

# Flags
#################
LDFLAGS		=	--oformat binary -Ttext 0x1000
#################

# Obj Files
#################
OBJ		=	$(PBOBJ)/*.o
#################

# Important Files
#################
BOOT		=	$(PBUILD)/boot_sector.bin
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
fos:	boot_sector kernel
	@echo "\n$(CBB)[ FOS ] Building.$(CN)"
	@cat $(BOOT) $(KRN) > $(FOS)
	@echo "$(CBG)[ FOS ] OK.$(CN)"

## Boot Sector Build.
.PHONY:	boot_sector
boot_sector:
	$(MAKE) -C $(PBOOT)

## Kernel Build.
.PHONY:	kernel
kernel:
	@echo "\n$(CBB)[ Kernel ] Building.$(CN)"
	$(MAKE) -C $(PKERNEL)
	$(MAKE) -C $(PDRIVERS)

	@echo "$(CBB)[ Kernel ] Linking Obj Files.$(CN)"
	@$(LD) -o $(KRN) $(LDFLAGS) $(PBUILD)/objs/*.o
	@echo "$(CBB)[ Kernel ] OK.$(CN)"
# [END] OS Bootstrap.

# Clean Rules.
.PHONY: clean
clean:
	@echo "$(CBB)[ Cleaning OBJ Files ]$(CN)$(B)"
	$(RM) $(OBJ)

.PHONY: fclean
fclean: clean
	@echo "$(CBB)[ Cleaning Main Files ]$(CN)$(B)"
	$(RM) $(BOOT)
	$(RM) $(KRN)
	$(RM) $(FOS)
	$(RM) $(PBUILD)
	@echo "$(CBG)[ Repository is all clean! Enjoy :) ]$(CN)"
# [END] Clean Rules.
