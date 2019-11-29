# Basics.
#################
SHELL		?=	/bin/sh
MAKE		=	@make --silent
#################

# Colors
#################
CN		=	\e[0m
CBB		=	\e[1;34m
CBG		=	\e[1;92m
#################


# Drivers
#################
SCREEN		=	./screen
#################


# Main Rules.
.PHONY:	all
all:
	@echo "$(CBB)[ Screen Driver ] Building.$(CN)"
	$(MAKE) -C $(SCREEN)
	@echo "$(CBG)[ Screen Driver ] OK.$(CN)"

## Debug.
.PHONY:	debug
debug:	MAKE += debug
debug:	all
# [END] Main Rules.
