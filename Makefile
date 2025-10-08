.PHONY : all clean fclean re bonus debug debug-print
NO_DIR = --no-print-directory
MAKE := $(MAKE) $(NO_DIR)
# MAKE := $(MAKE) -j $(NO_DIR)
NAME = inception

P_SRC = srcs/

all:
	@$(MAKE) $(NAME)

$(NAME):
	docker compose -f srcs/compose.yml up -d --force-recreate --remove-orphans

ls: list
list:
	docker ps

save:
	$(RSYNC_CMD)

ssh:
	$(SSH_CMD)

debug-print:
	@ls -Al -R --color=auto --ignore=.git

# Special Variable testing to adapt commands if on Alpine VM or not
HOST := $(shell hostname)
ifeq ($(HOST),alpine)
    RSYNC_CMD = @echo "Already on Alpine, please only use HOST"
	SSH_CMD = @echo "Already on Alpine, please use HOST to work"
else
    RSYNC_CMD = @echo "Sending all over SSH"; rsync -r --copy-links -e 'ssh -p 2200' ~/Documents/Inception/* ppontet@127.0.0.1:~/Inception --progress
	SSH_CMD = ssh -XC -p 2200 ppontet@127.0.0.1
start-vm:
	virtualboxvm --startvm Alpine --separate
stop-vm:
	vboxmanage controlvm Alpine acpipowerbutton
pull-vm:
	rsync -r ~/sgoinfre/Alpine ~/goinfre/ --progress
endif
