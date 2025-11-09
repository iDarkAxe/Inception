# Inception #

A project to learn Docker as a System Administrator.
It's mainly 3 Docker Containers assembled with a `compose.yml` file.

If you don't have all the rights/permissions on your HOST, you should set a VM. The VM is the REMOTE in this case.

## Usage ##

The only way to access the containers is by accessing the url from the nginx server. It could be `https://localhost/` or `https://username.42.fr` if you setupd `/etc/hosts` to point to `127.0.0.1` if the address is requested.

## Installation ##

You will need to use `docker`, if you don't have permissions to execute `docker compose` or anything related, please use a VM.

To properly setup the project, you need to create a `.env` file in `srcs/`. Fill the `here-*` with your values.
`OPENSSL_SUBJ` is only required for building images. `CN` as Common Name or server FQDN (Fully qualified domain name) could be simply `www.example.com`.

If you don't specify all the VARS, the build will stop. If you accept the risk, you can remove in the `compose.yml` file the `:?` after each environment varriable.

```txt
MYSQL_DATABASE=here-database-name
MYSQL_USER=here-user-for-db
WORDPRESS_DB_PASSWORD=here-password
WORDPRESS_DB_HOST=here-db-host:here-port
OPENSSL_SUBJ=C=here-country/ST=here-state/L=here-locality/O=here-organisation/OU=here-organisation-unit/CN=here-common-name
```

## Virtual Machines ##

If you are using a virtual machines, these commands will help you.

### How to send this project to your REMOTE ###

If you are working on the project, you should work on HOST as all your tools are already installed. You should only build and execute on REMOTE.
If it's not present :

```sh
make save
```

### List of commands ###

For Alpine OS users, you should have not run in live mode, an install is better for repeatability. You also need to enable Community packages, remove the starting `#` in the file `/etc/apk/repositories`. You will need theses tools for the project.
For other OSes, you can replace `apk add` with `apt install` or anything of your choice that uses a package manager.

```sh
setup-alpine
poweroff
```

```sh
apk update
apk add nano
apk add docker
apk add docker-compose
apk add rsync
apk add make
```

### For X11 Forwarding ###

Followed this tuto <https://some-natalie.dev/blog/ssh-x11-forwarding/>

If you need to use a browser like Firefox from inside (remote), you also need to install the following font as they are not marked as dependancies (you will see strange characters if you don't install them).

```sh
apk add font-noto font-noto-cjk font-dejavu font-liberation font-adobe-100dpi fontconfig
fc-cache -f -v
```

To access the VM with the following command :

```sh
ssh -XC -p <port> <user>@<ip_address>
```

- `X` means that X11 will forward applications to the client (you).
- `C` means that it will attemps to compress data (it helps reduce network bandwith but increase CPU usage).
- `p` is useful if you already are using default port of ssh (22).
