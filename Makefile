.PHONY : all clean fclean re bonus debug debug-print
NO_DIR = --no-print-directory
MAKE := $(MAKE) $(NO_DIR)
# MAKE := $(MAKE) -j $(NO_DIR)
NAME = inception

P_SRC = srcs/

all:
	@$(MAKE) $(NAME)

$(NAME):
	docker ps

debug-print:
	@ls -Al -R --color=auto --ignore=.git