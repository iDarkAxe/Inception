.PHONY : all clean fclean re bonus debug debug-print
NO_DIR = --no-print-directory
MAKE := $(MAKE) $(NO_DIR)
# MAKE := $(MAKE) -j $(NO_DIR)
NAME = inception

P_SRC = srcs/

all:
	@$(MAKE) $(NAME)

$(NAME):
	docker compose -f srcs/compose.yml up -d --build --force-recreate --remove-orphans

up:
	docker compose -f srcs/compose.yml up -d

ls: list
list:
	docker ps

save:
	$(RSYNC_CMD)

ssh:
	$(SSH_CMD)

stop:
	docker stop $(shell docker ps -q)

clean:
	docker system prune --all -f

clean-volumes:
	docker volume rm $(shell docker volume ls -q)

fclean:
	@$(MAKE) clean

re:
	@$(MAKE) fclean
	@$(MAKE) all

debug-print:
	@ls -Al -R --color=auto --ignore=.git

# Special Variable testing to adapt commands if on Alpine VM or not
HOST := $(shell hostname)
ifeq ($(HOST),alpine)
    RSYNC_CMD = @echo "Already on Alpine, please only use HOST"
	SSH_CMD = @echo "Already on Alpine, please use HOST to work"
else
    RSYNC_CMD = @echo "Sending all over SSH"; rsync -r --copy-links -e 'ssh -p 2200' ~/Documents/Inception/* ppontet@127.0.0.1:~/Inception
	SSH_CMD = ssh -XC -t -p 2200 ppontet@127.0.0.1 "cd ~/Inception && ash --login"
start-vm:
	VBoxManage startvm "Alpine" --type headless
stop-vm:
	VBoxManage controlvm "Alpine" acpipowerbutton
pull-vm:
	rsync -r ~/sgoinfre/Alpine ~/goinfre/ --progress
push-vm:
	rsync -r ~/goinfre/Alpine ~/sgoinfre/ --progress
endif
