# Help #

All tips that couldn't be in README.md

VM should be placed in ~/goinfre for better performance.

If it's not present :

```sh
rsync -r ~/sgoinfre/Alpine ~/goinfre/ --progress
```

To save your progress :

```sh
rsync -r ~/goinfre/Alpine ~/sgoinfre/ --progress
```

## How to send all this project to your VM ##

If it's not present :

```sh
rsync -r -e 'ssh -p 2200' ./* ppontet@127.0.0.1:~/Inception --progress
```

To save your progress :

```sh
rsync -r -e 'ssh -p 2200' ./Inception* ppontet@127.0.0.0:~/Documents/Inception/backup --progress
```

## Some Vars ##

SSH port used is default but in VirtualBox it's forwarded on 2200.
It's already accessible as ssh key is in the VM.

```sh
ssh -p 2200 ppontet@127.0.0.1
```

## Pense bête ##

```sh
ln -s ~/Documents/Inception/srcs/.dockerignore srcs/mariadb
ln -s ~/Documents/Inception/srcs/.dockerignore srcs/nginx
ln -s ~/Documents/Inception/srcs/.dockerignore srcs/wordpress
```

## List of commands ##

```sh
setup-alpine
poweroff
```

```sh
apk add nano
apk add docker
apk add docker-compose
apk add rsync
```

## For X11 Forwarding ##

Followed this tuto <https://some-natalie.dev/blog/ssh-x11-forwarding/>

Back'd up :

* `/etc/ssh/sshd_config` into `/etc/ssh/sshd_config.bak`
* `/etc/ssh/ssh_config` into `/etc/ssh/ssh_config`

```sh
apk add font-noto font-noto-cjk font-dejavu font-liberation font-adobe-100dpi fontconfig
fc-cache -f -v
```
