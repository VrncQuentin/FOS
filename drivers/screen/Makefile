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
CBB		=	\e[1;34m
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
.PHONY:	all
all:	$(OBJ)
	@mv $(OBJ) $(PBUILD)
	@echo "$(CBB)[ Screen Driver ] Moved to builds/objs/.$(CN)"

## Debug
.PHONY: debug
debug:	CFLAGS += -DDEBUG
debug:	all
# [END] Main Rules.

# Conversion Rule.
%.o:	%.c
	@echo "$(CBW)[ drivers/screen/$< ]\t==>>\t[ drivers/screen/$@ ]$(CN)"
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@
# [END] Conversion Rule.
