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
CBB		=	\e[1;34m
CBG		=	\e[1;92m
CBW		=	\e[1;97m
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
	@echo "Running [ $(FOS) ]"
	@$(EMUL) $(FOS)

# .PHONY: disass
# disass: $(KRN_NAME)
# 	ndisasm -b 32 $<

# .PHONY: debug
# debug: CFLAGS += t-DDEBUG
# debug: #TODO: Fix
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
	cat $(BOOT) $(KRN) > $(FOS)
	@echo "\n$(CBG)[ FOS ] OK.$(CN)"

## Boot Sector Build.
.PHONY:	boot_sector
boot_sector:
	@echo "\n$(CBB)[ Boot Sector ] Building.$(CN)"
	$(MAKE) -C $(PBOOT)
	@echo "$(CBG)[ Boot Sector ] OK.$(CN)"

## Kernel Build.
.PHONY:	kernel
kernel:
	@echo "\n$(CBB)[ Kernel ] Building.$(CN)"

	@echo "$(CBB)[ Kernel's OBJ Files ] Building.$(CN)"
	$(MAKE) -C $(PKERNEL)
	@echo "$(CBG)[ Kernel's OBJ Files ] OK.$(CN)"

	@echo "\n$(CBB)[ Driver's OBJ Files ] Building.$(CN)"
	$(MAKE) -C $(PDRIVERS)
	@echo "$(CBG)[ Driver's OBJ Files ] OK.$(CN)"

	@$(LD) -o $(KRN) $(LDFLAGS) $(PBUILD)/objs/*.o
	@echo "\n$(CBB)[ Kernel ] OK.$(CN)"
# [END] OS Bootstrap.

# Clean Rules.
.PHONY: clean
clean:
	@echo "$(CBB)[ Cleaning OBJ Files ]$(CN)"
	$(RM) $(OBJ)

.PHONY: fclean
fclean: clean
	@echo "$(CBB)[ Cleaning Main Files ]$(CN)"
	$(RM) $(BOOT)
	$(RM) $(KRN)
	$(RM) $(FOS)
	$(RM) $(PBUILD)
	@echo "$(CBG)[ Repository is all clean! Enjoy :) ]$(CN)"
# [END] Clean Rules.
