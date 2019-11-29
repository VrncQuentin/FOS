# Basics.
#################
SHELL		?=	/bin/sh
MAKE		=	@make --silent
#################

# Colors
#################
B		=	\e[1m
CN		=	\e[0m
CBB		=	\e[1;34m
CBG		=	\e[1;92m
#################


# Drivers
#################
SCREEN		=	./screen
#################


# Main Rules.
## Drivers Objs.
all:	disp_entry
	$(MAKE) -C $(SCREEN)
	@echo "$(B)|---$(CBG)[ Driver's OBJ Files ] OK.$(CN)"

## Debug.
debug:	MAKE += debug
debug:	all
# [END] Main Rules.

# Misc.
disp_entry:
	@echo "$(B)|\n|---$(CBB)[ Driver's OBJ Files ] Building.$(CN)"

.PHONY: all debug disp_entry
# [END] Misc.
