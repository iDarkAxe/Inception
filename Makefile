.PHONY : all clean fclean re bonus debug debug-print
NO_DIR = --no-print-directory
MAKE := $(MAKE) $(NO_DIR)
# MAKE := $(MAKE) -j $(NO_DIR)
NAME = inception

USER = $(shell whoami)
REMOTE = $(shell whoami)@127.0.0.1
SSH_PORT = 2200
SERVICES_NAMES = mariadb nginx wordpress
VOLUMES_NAMES = db web

all:
	@$(MAKE) $(NAME)

$(NAME):
	mkdir -p /home/$(USER)/data/db /home/$(USER)/data/web
	docker compose -f srcs/compose.yml up -d --build --force-recreate --remove-orphans

up:
	mkdir -p /home/$(USER)/data/db /home/$(USER)/data/web
	docker compose -f srcs/compose.yml up -d

ls: list
list:
	docker ps

save:
	$(RSYNC_CMD)

ssh:
	$(SSH_CMD)

stop:
	docker stop $(SERVICES_NAMES)

stop-all:
	docker stop $(shell docker ps -q)

clean:
clean-all:
	docker system prune --all -f

clean-volumes:
	docker volume rm $(VOLUMES_NAMES)

clean-all-volumes:
	docker volume rm $(shell docker volume ls -q)

fclean:
	@$(MAKE) stop
	@$(MAKE) clean-all

re:
	@$(MAKE) fclean
	@$(MAKE) all

debug-print:
	@ls -Al -R --color=auto --ignore=.git

# Special Variable testing to adapt commands if on Alpine VM or not
HOST := $(shell hostname)
ifeq ($(HOST),alpine) #on REMOTE

RSYNC_CMD = @echo "Already on Alpine, please only use HOST"
SSH_CMD = @echo "Already on Alpine, please use HOST to work"

else #on HOST

RSYNC_CMD = @echo "Sending all over SSH"; rsync -r --copy-links -e 'ssh -p $(SSH_PORT)' ~/Documents/Inception/ $(REMOTE):~/Inception
SSH_CMD = ssh -XC -t -p $(SSH_PORT) $(REMOTE) "cd ~/Inception && sh --login"

start-vm:
	VBoxManage startvm "Alpine" --type headless
stop-vm:
	VBoxManage controlvm "Alpine" acpipowerbutton
pull-vm:
	rsync -r ~/sgoinfre/Alpine ~/goinfre/ --progress
push-vm:
	rsync -r ~/goinfre/Alpine ~/sgoinfre/ --progress
endif
