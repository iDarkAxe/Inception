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

save:
	$(RSYNC_CMD)

debug-print:
	@ls -Al -R --color=auto --ignore=.git

	$(call save_backup,$(NAME),"Project")

HOST := $(shell hostname)
ifeq ($(HOST),alpine)
    RSYNC_CMD = @echo "Already on Alpine, please only use HOST"
else
    RSYNC_CMD = @echo "Sending all over SSH"; rsync -e 'ssh -p 2200' ./* ppontet@127.0.0.1:~/Inception --progress
endif
