# Basics
#################
SHELL		?=	/bin/sh
RM		?=	-rm -rf
CC		=	gcc
#################

# Flags
#################
CFLAGS		=	-ffreestanding -Wall -Wextra -Werror
CPPFLAGS	=	-iquote $(PHEADERS)
#################

# Colors
#################
CN		=	\e[0m
B		=	\e[1m
CBB		=	\e[1;34m
CBM		=	\e[1;35m
CBG		=	\e[1;92m
CBW		=	\e[1;97m
#################

# Path
#################
PBUILD		=	../../build/objs
PHEADERS	=	../../include
#################

# Sources
#################
SRC		=	cursor.c	\
			scrolling.c	\
			print.c		\
			clear.c		\
#################

# Obj Files
#################
OBJ		=	$(SRC:.c=.o)
#################


# Main Rules.
## Screen Objs.
all:	disp_entry $(OBJ)
	@mv $(OBJ) $(PBUILD)
	@echo "$(B)        |---$(CBM)[ Screen Driver ] Moved to builds/objs/.$(CN)"
	@echo "$(B)    |---$(CBG)[ Screen Driver ] OK.$(CN)"

## Debug
debug:	CFLAGS += -DDEBUG
debug:	all
# [END] Main Rules.

# Conversion Rule.
%.o:	%.c
	@echo "$(B)        |---$(CBW)[ drivers/screen/$< ]\t==>>\t[ drivers/screen/$@ ]$(CN)"
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@
# [END] Conversion Rule.

# Misc.
disp_entry:
	@echo "$(B)    |---$(CBB)[ Screen Driver ] Building.$(CN)"

.PHONY: all debug disp_entry
# [END] Misc.
